module Api
  module V1
    class WeekdaysController < ApiController
      skip_before_action :authenticate_user!

      def index
        weekdays = WeekDaySchedule::WEEKDAYS.map{|i, d| [i, I18n.t("weekday.#{d}")]}.to_h
        render json: weekdays
      end
    end
  end
end
