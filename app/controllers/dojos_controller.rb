class DojosController < ApplicationController
  before_action :set_dojo, only: [:show, :edit, :update, :destroy]

  # GET /dojos
  # GET /dojos.json
  def index
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @dojos = Dojo.all
  end

  # GET /dojos/1
  # GET /dojos/1.json
  def show
  end

  # GET /dojos/new
  def new
    if !current_user
      redirect_to "/"
      return
    end
    @dojo = Dojo.new
    my_address = Geocoder.search(request.remote_ip)
    if my_address[0]
      @dojo.latitude = my_address[0].latitude
      @dojo.longitude = my_address[0].longitude
    else
      @dojo.latitude = 36.125
      @dojo.longitude = -115.175
    end
  end

  # GET /dojos/1/edit
  def edit
    if !@dojo.userIsAdmin current_user
      redirect_to "/"
      return
    end
  end

  # POST /dojos
  # POST /dojos.json
  def create
    if !current_user
      redirect_to "/"
      return
    end

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
    if !@dojo.userIsAdmin current_user
      redirect_to "/"
      return
    end
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
    if !userIsAdmin
      redirect_to "/"
      return
    end

    @dojo.destroy
    respond_to do |format|
      format.html { redirect_to dojos_url }
      format.json { head :no_content }
    end
  end

  def manage_users
    @dojo = Dojo.find_by_id(params[:dojo_id])
    if !@dojo.userIsAdmin current_user
      redirect_to "/"
      return
    end

    @dojo = Dojo.find_by_id(params[:dojo_id])
    @like_param = params["like_param"]
    @remove_admin = params["remove_admin"]
    @make_admin = params["make_admin"]
    @invite_user = params["invite_user"]
    @kick = params["kick"]
    if @like_param=="" || @like_param == nil
      @users=[]
    else
      @users=User.where("name LIKE ?" , "%#{@like_param}%")
    end
    if @remove_admin!="" && @remove_admin != nil
      @user_in_dojo = UserInDojo.where(user: User.find_by_id(@remove_admin),dojo: @dojo)[0]
      @user_in_dojo.is_admin = false
      @user_in_dojo.save
    end
    if @make_admin!="" && @make_admin != nil
      @user_in_dojo = UserInDojo.where(user: User.find_by_id(@make_admin),dojo: @dojo)[0]
      @user_in_dojo.is_admin = true
      @user_in_dojo.save
    end
    if @invite_user!="" && @invite_user != nil
      @dojo_invitation = DojoInvitation.create(user: User.find_by_id(@invite_user),dojo: @dojo,admin_id: current_user.id)
      @dojo_invitation.save
    end
    if @kick!="" && @kick != nil
      @user_in_dojo = UserInDojo.where(user: User.find_by_id(@kick),dojo: @dojo)[0]
      @user_in_dojo.destroy
    end
  end

  def accept_invitation
    if !current_user
      redirect_to "/"
      return
    end

    @dojo_invitation = DojoInvitation.find_by_id(params["dojo_invitation_id"])
    @dojo = @dojo_invitation.dojo
    @user_in_dojo = UserInDojo.create(user: current_user,dojo: @dojo_invitation.dojo,is_admin: false)
    @dojo_invitation.destroy
    @user_in_dojo.save
    redirect_to @dojo
  end

  def decline_invitation
    if !current_user
      redirect_to "/"
      return
    end

    @dojo_invitation = DojoInvitation.find_by_id(params["dojo_invitation_id"])
    @dojo_invitation.destroy
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
