module CdAdmin
  class CategoriesController < AdminController
    before_action :set_cd_admin_category, only: [:show, :edit, :update, :destroy]

    def index
      @categories = ::Category.page(params[:page] || 1)
    end

    def show
    end

    def edit
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.create(category_params)
      if @category.errors.blank?
        redirect_to cd_admin_category_path(@category), notice: 'Category was successfully created.'
      else
        render :new
      end
    end

    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html {redirect_to cd_admin_category_path(@category), notice: 'Category was successfully updated.'}
          format.json {render :show, status: :ok, location: @category}
        else
          format.html {render :edit}
          format.json {render json: @category.errors, status: :unprocessable_entity}
        end
      end
    end

    def destroy
      @category.destroy
      respond_to do |format|
        format.html {redirect_to cd_admin_categories_url, notice: 'Category was successfully destroyed.'}
        format.json {head :no_content}
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_cd_admin_category
      @category = ::Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :en_lang_name)
    end
  end
end
