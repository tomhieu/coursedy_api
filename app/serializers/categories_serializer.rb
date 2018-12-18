class CategoriesSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :course_levels,
             :children

  def name
    if @instance_options[:locale] == :en
      name
    else
      en_lang_name
    end
  end

  def children
    object.children.map do |child|
      child_name = @instance_options[:locale] == :en ? child.name : child.en_lang_name
      {id: child.id, name: child_name, course_levels: child.course_levels.map{|level| {id: level.id, name: level.name}}}
    end
  end

  def course_levels
    object.course_levels.map{|level| {id: level.id, name: level.name}}
  end
end