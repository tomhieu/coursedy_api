module CdAdmin
  class TutorsController < AdminController

    before_action :set_cd_admin_tutor, only: [:show, :edit, :update, :destroy]

    # GET /cd_admin/tutors
    # GET /cd_admin/tutors.json
    def index
      @cd_admin_tutors = ::Tutor.unscoped.includes(:user, :categories, :tutor_educations).order(:status).page(params[:page] || 1)
    end

    # GET /cd_admin/tutors/1
    # GET /cd_admin/tutors/1.json
    def show
    end

    # GET /cd_admin/tutors/1/edit
    def edit
    end

    # PATCH/PUT /cd_admin/tutors/1
    # PATCH/PUT /cd_admin/tutors/1.json
    def update
      respond_to do |format|
        if @cd_admin_tutor.update(cd_admin_tutor_params)
          format.html {redirect_to cd_admin_tutor_path(@cd_admin_tutor), notice: 'Tutor was successfully updated.'}
          format.json {render :show, status: :ok, location: @cd_admin_tutor}
        else
          format.html {render :edit}
          format.json {render json: @cd_admin_tutor.errors, status: :unprocessable_entity}
        end
      end
    end

    # DELETE /cd_admin/tutors/1
    # DELETE /cd_admin/tutors/1.json
    def destroy
      # @cd_admin_tutor.destroy
      # respond_to do |format|
      #   format.html { redirect_to cd_admin_tutors_url, notice: 'Tutor was successfully destroyed.' }
      #   format.json { head :no_content }
      # end
      redirect_to :back, alert: "you're not allow to perform this action"
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_cd_admin_tutor
      @cd_admin_tutor = ::Tutor.unscoped.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cd_admin_tutor_params
      params.require(:tutor).permit(:title, :description, :hour_rate, :highest_education, :teach_online, :currency, :place_of_work, :status)
    end
  end
end

