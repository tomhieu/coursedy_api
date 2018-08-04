class TutorsSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :place_of_work, :description, :user_id, :user, :degrees, :hour_rate, :categories, :currency, :created_at, :updated_at

  def user
    if @instance_options[:full_info] && object.user
      user= object.user
      avatar = user.avatar&.url
      avatar = AppSettings.asset_host + avatar if avatar
      {name: user.name, avatar: avatar, rating_count: user.rating_count, rating_points: user.rating_points, email: user.email, date_of_birth: user.date_of_birth}
    end
  end

  def degrees
    object.degrees.map{|d| DegreesSerializer.new(d).to_h}
  end

  def categories
    object.categories.map{|c| {id: c.id, name: c.name}}
  end

  # def districts
  #   object.districts.map{|d| {id: d.id, name: d.name}}
  # end
end