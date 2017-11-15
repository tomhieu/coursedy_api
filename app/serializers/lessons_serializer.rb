class LessonsSerializer < ActiveModel::Serializer
  attributes :title, :course_id, :course_section_id, :period, :description, :documents

  def documents
    result = []
    object.documents.each do |doc|
      result.push({id: doc.id, url: doc.item.url})
    end
    result
  end
end