class LessonsSerializer < ActiveModel::Serializer
  attributes :id, :title, :course_id, :course_section_id, :period, :description, :documents

  def documents
    result = []
    object.documents.each do |doc|
      result.push({id: doc.id, url: doc.item.url, name: doc.item.file.original_filename})
    end
    result
  end
end