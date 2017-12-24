class CategoriesSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :course_levels,
             :children

  def children
    object.children.map do |child|
      CategoriesSerializer.new(child).as_json
    end
  end

  def course_levels
    object.course_levels.map{|level| {id: level.id, name: level.name}}
  end
end