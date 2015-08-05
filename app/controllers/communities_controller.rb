class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :edit, :update, :destroy]

  # GET /communities
  # GET /communities.json
  def index
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @communities = Community.all
  end

  # GET /communities/1
  # GET /communities/1.json
  def show
    @differences = @community.getDifference
    @streaks = @community.getStreak
  end

  # GET /communities/new
  def new
    if !current_user
      redirect_to "/"
      return
    end
    @community = Community.new
    my_address = Geocoder.search(request.remote_ip)
    if my_address[0]
      @latitude = my_address[0].latitude
      @longitude = my_address[0].longitude
    else
      @latitude = 36.125
      @longitude = -115.175
    end
  end

  # GET /communities/1/edit
  def edit
    if !@community.userIsAdmin current_user
      redirect_to "/"
      return
    end
    my_address = Geocoder.search(request.remote_ip)
    if my_address[0]
      @latitude = my_address[0].latitude
      @longitude = my_address[0].longitude
    else
      @latitude = 36.125
      @longitude = -115.175
    end
  end

  # POST /communities
  # POST /communities.json
  def create
    if !current_user
      redirect_to "/"
      return
    end

    @community = Community.new(community_params)

    @community.main_image = params[:main_image]

    respond_to do |format|
      if @community.save
        UserInCommunity.create(community: @community,user: current_user,is_admin: true)
        community_points = params[:community_points]
        points = community_points.split(',')
        for i in 0..(points.count/2)-1
          latitude = 0
          longitude = 0
          for j in 0..1
            latitude = points[i*2]
            longitude = points[i*2+1]
          end
          CommunityPoint.create(community: @community, latitude: latitude, longitude: longitude)
        end

        format.html { redirect_to @community, notice: 'Community was successfully created.' }
        format.json { render action: 'show', status: :created, location: @community }
      else
        format.html { render action: 'new' }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /communities/1
  # PATCH/PUT /communities/1.json
  def update
    if !@community.userIsAdmin current_user
      redirect_to "/"
      return
    end
    respond_to do |format|
      if @community.update(community_params)
        CommunityPoint.where(:community => @community).destroy_all
        community_points = params[:community_points]
        points = community_points.split(',')
        for i in 0..(points.count/2)-1
          latitude = 0
          longitude = 0
          for j in 0..1
            latitude = points[i*2]
            longitude = points[i*2+1]
          end
          CommunityPoint.create(community: @community, latitude: latitude, longitude: longitude)
        end
        format.html { redirect_to @community, notice: 'Community was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy
    if !userIsAdmin
      redirect_to "/"
      return
    end

    @community.destroy
    respond_to do |format|
      format.html { redirect_to communities_url }
      format.json { head :no_content }
    end
  end

  def manage_users
    @community = Community.find_by_id(params["community_id"])
    if !@community.userIsAdmin current_user
      redirect_to "/"
      return
    end

    @community = Community.find_by_id(params[:community_id])
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
      @user_in_community = UserInCommunity.where(user: User.find_by_id(@remove_admin),community: @community)[0]
      @user_in_community.is_admin = false
      @user_in_community.save
    end
    if @make_admin!="" && @make_admin != nil
      @user_in_community = UserInCommunity.where(user: User.find_by_id(@make_admin),community: @community)[0]
      @user_in_community.is_admin = true
      @user_in_community.save
    end
    if @invite_user!="" && @invite_user != nil
      UserInCommunity.create(user: User.find_by_id(@invite_user),community: @community,is_admin: false)
    end
    if @kick!="" && @kick != nil
      @user_in_community = UserInCommunity.where(user: User.find_by_id(@kick),community: @community)[0]
      @user_in_community.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_params
      params.require(:community).permit(:name, :description, :main_image, :is_admin)
    end
end
