# -*- coding: utf-8 -*-
require 'bigbluebutton_api'

class Bigbluebutton::Api::RoomsController < Api::V1::ApiController
  include BigbluebuttonRails::APIControllerMethods

  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  before_action :validate_pagination, only: :index

  before_action :find_room, only: [:running, :join]

  before_action :join_user_params, only: :join

  # only for the ones that trigger API calls
  before_action :set_request_headers, only: [:join, :running]
  before_action :set_content_type

  respond_to :json

  def index
    query = BigbluebuttonRoom

    # Search
    search_terms = map_search(params[:filter])
    query = query.search_by_terms(search_terms) unless search_terms.blank?

    # Sort
    sort_str = map_sort(params[:sort], 'name ASC', ['activity', 'name'])
    if sort_str.match(/activity/) # if requested activity ignore the rest
      activity_order = sort_str.match(/activity ASC/) ? 'DESC' : 'ASC' # yes, inverse logic!
      query = query.order_by_activity(activity_order)
    else
      query = query.order(sort_str)
    end

    # Limits and pagination
    limit, offset, page = map_pagination(params[:page], 10)
    query = query.limit(limit).offset(offset)
    @pagination_links = map_pagination_links(page)

    @rooms = query
    respond_with(@rooms)
  end

  def running
    check_is_running
  end

  def join
    unless (info = @room.fetch_meeting_info).nil?
      if info[:attendees].map{|x| x[:userID].to_i}.include?(current_user.id)
        render json: {errors: ['user already join the room']}, status: 404
        return
      end
    end
    join_internal(@user_name, @user_role, current_user.id, params[:lesson_id])
  end

  def join_mobile
    filtered_params = select_params_for_join_mobile(params.clone)
    @join_mobile = join_bigbluebutton_room_url(@room, filtered_params.merge({:auto_join => '1' }))
    @join_desktop = join_bigbluebutton_room_url(@room, filtered_params.merge({:desktop => '1' }))
  end

  protected

  def join_internal(username, role, id, lesson_id)
    begin
      # first check if we have to create the room and if the user can do it
      unless @room.fetch_is_running?
        # update logout url for teaching room
        started_lesson = Lesson.find(lesson_id)
        @room.logout_url = "https://coursedy.com/lessons/#{lesson_id}/review"
        @room.name = started_lesson.title
        if bigbluebutton_can_create?(@room, role) && @room.create_meeting(current_user, request)
          logger.info "Meeting created: id: #{@room.meetingid}, name: #{@room.name}, created_by: #{username}, time: #{Time.now.iso8601}"
          # update lesson status is started after meeting is created
          started_lesson.update(status: Lesson::STARTED)
        else
          error_room_not_running
          return
        end
      end

      # room created and running, try to join it
      url = @room.parameterized_join_url(username, role, id, {joinViaHtml5: true, avatarURL: current_user.avatar&.url}, current_user)

      unless url.nil?
        # change the protocol to join with a mobile device
        if BigbluebuttonRails.use_mobile_client?(browser) &&
          !BigbluebuttonRails.value_to_boolean(params[:desktop])
          url.gsub!(/^[^:]*:\/\//i, "bigbluebutton://")
        end

        respond_with(url: url)
      else
        error_room_not_running
        return
      end

    rescue BigBlueButton::BigBlueButtonException => e
      error_room_not_running
    end
  end

  def find_room
    @room ||= BigbluebuttonRoom.find_by(slug: params[:id])
    error_room_not_found if @room.nil?
  end

  def join_user_params
    if BigbluebuttonRails.configuration.guest_support
      guest_role = :guest
    else
      guest_role = :attendee
    end

    @user_name = current_user.name
    return error_missing_params if @user_name.blank?

    if @room.private
      course = Course.find_by_bigbluebutton_room_id(@room.id)
      key = nil
      if course.user_id == current_user.id
        key = @room.moderator_key
      elsif course.participations.pluck(:user_id).include?(current_user.id)
        key = @room.attendee_key
      end
      return error_missing_params if key.blank?
      @user_role = @room.user_role(key)
      return error_invalid_key if @user_role.blank?
    else
      @user_role = guest_role
    end
  end

  def check_is_running
    begin
      @room.fetch_is_running?
    rescue StandardError => e
      @errors = [BigbluebuttonRails::APIError.new(e.to_s, 500)]
      error_room_not_running
    end
    @room.is_running?
  end

  def set_content_type
    self.content_type = 'application/vnd.api+json'
  end

  def set_request_headers
    @room.request_headers["x-forwarded-for"] = request.remote_ip if @room.present?
  end

  def error_room_not_running
    render_error_response('not found', 404)
  end
end
