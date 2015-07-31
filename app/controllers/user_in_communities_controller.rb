class UserInCommunitiesController < ApplicationController
  before_action :set_user_in_community, only: [:show, :edit, :update, :destroy]

  # GET /user_in_communities
  # GET /user_in_communities.json
  def index
    @user_in_communities = UserInCommunity.all
  end

  # GET /user_in_communities/1
  # GET /user_in_communities/1.json
  def show
  end

  # GET /user_in_communities/new
  def new
    @user_in_community = UserInCommunity.new
  end

  # GET /user_in_communities/1/edit
  def edit
  end

  # POST /user_in_communities
  # POST /user_in_communities.json
  def create
    @user_in_community = UserInCommunity.new(user_in_community_params)

    respond_to do |format|
      if @user_in_community.save
        format.html { redirect_to @user_in_community, notice: 'User in community was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_in_community }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_in_community.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_in_communities/1
  # PATCH/PUT /user_in_communities/1.json
  def update
    respond_to do |format|
      if @user_in_community.update(user_in_community_params)
        format.html { redirect_to @user_in_community, notice: 'User in community was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_in_community.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_in_communities/1
  # DELETE /user_in_communities/1.json
  def destroy
    @user_in_community.destroy
    respond_to do |format|
      format.html { redirect_to user_in_communities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_in_community
      @user_in_community = UserInCommunity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_in_community_params
      params.require(:user_in_community).permit(:user_id, :community_id)
    end
end
