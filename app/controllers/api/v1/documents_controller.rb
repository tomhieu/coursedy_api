module Api
  module V1
    class DocumentsController < ApiController
      def create
        @document = Document.create(document_params)
        if @document.errors.messages.count > 0
          render_error_response(@document.errors.full_messages.first, :unprocessable_entity)
        else
          render json: @document, serializer: DocumentsSerializer
        end
      end

      def show
        @document = Document.find(params[:id])
        render json: @document, serializer: DocumentsSerializer
      end

      def index
        @document = Document.where(section_id: params[:section_id]).includes(:documents)
        render json: @document, each_serializer: DocumentsSerializer
      end

      def update
        @document = Document.where(id: params[:id])

        if @document.update_attributes(document_params)
          render json: @document, serializer: CourseSectionSerializer
        else
          render_error_response(@document.errors.full_messages.first, :unprocessable_entity)
        end
      end

      def destroy
        @document = Document.find(params[:id])
        @document.destroy
        render json: {id: @document.id}
      end

      private

      def document_params
        params.require(:document).permit(:item, :lesson_id, name)
      end
    end
  end
end