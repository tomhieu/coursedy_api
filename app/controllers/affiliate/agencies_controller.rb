class Affiliate::AgenciesController < ApplicationController
  before_action :set_affiliate_agency, only: [:show, :edit, :update, :destroy]

  # GET /affiliate/agencies
  # GET /affiliate/agencies.json
  def index
    @affiliate_agencies = Affiliate::Agency.all
  end

  # GET /affiliate/agencies/1
  # GET /affiliate/agencies/1.json
  def show
  end

  # GET /affiliate/agencies/new
  def new
    @affiliate_agency = Affiliate::Agency.new
  end

  # GET /affiliate/agencies/1/edit
  def edit
  end

  # POST /affiliate/agencies
  # POST /affiliate/agencies.json
  def create
    @affiliate_agency = Affiliate::Agency.new(affiliate_agency_params)

    respond_to do |format|
      if @affiliate_agency.save
        format.html { redirect_to @affiliate_agency, notice: 'Agency was successfully created.' }
        format.json { render :show, status: :created, location: @affiliate_agency }
      else
        format.html { render :new }
        format.json { render json: @affiliate_agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /affiliate/agencies/1
  # PATCH/PUT /affiliate/agencies/1.json
  def update
    respond_to do |format|
      if @affiliate_agency.update(affiliate_agency_params)
        format.html { redirect_to @affiliate_agency, notice: 'Agency was successfully updated.' }
        format.json { render :show, status: :ok, location: @affiliate_agency }
      else
        format.html { render :edit }
        format.json { render json: @affiliate_agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /affiliate/agencies/1
  # DELETE /affiliate/agencies/1.json
  def destroy
    @affiliate_agency.destroy
    respond_to do |format|
      format.html { redirect_to affiliate_agencies_url, notice: 'Agency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_affiliate_agency
      @affiliate_agency = Affiliate::Agency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def affiliate_agency_params
      params.require(:affiliate_agency).permit(:name, :description, :address, :phone, :domain, :user_id)
    end
end
