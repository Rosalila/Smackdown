class DojosController < ApplicationController
  before_action :set_dojo, only: [:show, :edit, :update, :destroy]

  # GET /dojos
  # GET /dojos.json
  def index
    @dojos = Dojo.all
  end

  # GET /dojos/1
  # GET /dojos/1.json
  def show
  end

  # GET /dojos/new
  def new
    @dojo = Dojo.new
    my_address = Geocoder.search("190.124.164.129")
    @dojo.latitude = my_address[0].latitude
    @dojo.longitude = my_address[0].longitude
  end

  # GET /dojos/1/edit
  def edit
  end

  # POST /dojos
  # POST /dojos.json
  def create
    @dojo = Dojo.new(dojo_params)

    @dojo.main_image = params[:main_image]
    @dojo.badge_image = params[:badge_image]

    respond_to do |format|
      if @dojo.save
        @user_in_dojo = UserInDojo.new
        @user_in_dojo.user = current_user
        @user_in_dojo.dojo = @dojo
        @user_in_dojo.is_admin = true
        @user_in_dojo.save
        format.html { redirect_to @dojo, notice: 'Dojo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dojo }
      else
        format.html { render action: 'new' }
        format.json { render json: @dojo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dojos/1
  # PATCH/PUT /dojos/1.json
  def update
    respond_to do |format|
      if @dojo.update(dojo_params)
        format.html { redirect_to @dojo, notice: 'Dojo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dojo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dojos/1
  # DELETE /dojos/1.json
  def destroy
    @dojo.destroy
    respond_to do |format|
      format.html { redirect_to dojos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dojo
      @dojo = Dojo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dojo_params
      params.require(:dojo).permit(:name, :main_image, :badge_image, :about, :motto, :schedule, :public_address, :latitude, :longitude)
    end
end
