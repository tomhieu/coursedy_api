class LessonsSerializer < ActiveModel::Serializer
  attributes :id, :title, :course_id, :course_section_id, :period, :description, :documents, :created_at, :updated_at, :status

  def documents
    result = []
    object.documents.each do |doc|
      result.push(DocumentsSerializer.new(doc).to_h)
    end
    result
  end
end