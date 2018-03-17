class TutorsSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user_id, :user, :degrees, :hour_rate, :highest_education, :categories, :currency

  def user
    if @instance_options[:full_info]
      UsersSerializer.new(object.user).to_h
    end
  end

  def degrees
    object.degrees.map{|d| {id: d.id,url: d.item.url, name: d.item.file.original_filename}}
  end

  def categories
    object.categories.map{|c| {id: c.id, name: c.name}}
  end

  # def districts
  #   object.districts.map{|d| {id: d.id, name: d.name}}
  # end
end