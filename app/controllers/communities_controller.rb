class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :edit, :update, :destroy]

  # GET /communities
  # GET /communities.json
  def index
    @communities = Community.all
  end

  # GET /communities/1
  # GET /communities/1.json
  def show
  end

  # GET /communities/new
  def new
    if !current_user
      redirect_to "/"
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
  end

  # POST /communities
  # POST /communities.json
  def create
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
    respond_to do |format|
      if @community.update(community_params)
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
    @community.destroy
    respond_to do |format|
      format.html { redirect_to communities_url }
      format.json { head :no_content }
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
