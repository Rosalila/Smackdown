class CommunityPointsController < ApplicationController
  before_action :set_community_point, only: [:show, :edit, :update, :destroy]

  # GET /community_points
  # GET /community_points.json
  def index
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @community_points = CommunityPoint.all
  end

  # GET /community_points/1
  # GET /community_points/1.json
  def show
    if !userIsAdmin
      redirect_to "/"
      return
    end
  end

  # GET /community_points/new
  def new
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @community_point = CommunityPoint.new
  end

  # GET /community_points/1/edit
  def edit
    if !userIsAdmin
      redirect_to "/"
      return
    end
  end

  # POST /community_points
  # POST /community_points.json
  def create
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @community_point = CommunityPoint.new(community_point_params)

    respond_to do |format|
      if @community_point.save
        format.html { redirect_to @community_point, notice: 'Community point was successfully created.' }
        format.json { render action: 'show', status: :created, location: @community_point }
      else
        format.html { render action: 'new' }
        format.json { render json: @community_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /community_points/1
  # PATCH/PUT /community_points/1.json
  def update
    if !userIsAdmin
      redirect_to "/"
      return
    end
    respond_to do |format|
      if @community_point.update(community_point_params)
        format.html { redirect_to @community_point, notice: 'Community point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @community_point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /community_points/1
  # DELETE /community_points/1.json
  def destroy
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @community_point.destroy
    respond_to do |format|
      format.html { redirect_to community_points_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community_point
      @community_point = CommunityPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_point_params
      params.require(:community_point).permit(:community_id, :latitude, :longitude)
    end
end
