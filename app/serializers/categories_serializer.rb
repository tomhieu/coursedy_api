class CategoriesSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :course_levels

  def course_levels
    object.course_levels.map{|level| {id: level.id, name: level.name}}
  end
end