class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:show, :edit, :update, :destroy]

  # GET /favorites
  # GET /favorites.json
  def index
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @favorites = Favorite.all
  end

  # GET /favorites/1
  # GET /favorites/1.json
  def show
    if !userIsAdmin
      redirect_to "/"
      return
    end
  end

  # GET /favorites/new
  def new
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @favorite = Favorite.new
  end

  # GET /favorites/1/edit
  def edit
    if !userIsAdmin
      redirect_to "/"
      return
    end
  end

  # POST /favorites
  # POST /favorites.json
  def create
    if !userIsAdmin
      redirect_to "/"
      return
    end

    @favorite = Favorite.new(favorite_params)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to @favorite, notice: 'Favorite was successfully created.' }
        format.json { render action: 'show', status: :created, location: @favorite }
      else
        format.html { render action: 'new' }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorites/1
  # PATCH/PUT /favorites/1.json
  def update
    if !userIsAdmin
      redirect_to "/"
      return
    end

    respond_to do |format|
      if @favorite.update(favorite_params)
        format.html { redirect_to @favorite, notice: 'Favorite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    if !userIsAdmin
      redirect_to "/"
      return
    end

    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to favorites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorite_params
      params.require(:favorite).permit(:user_id, :favorited_id)
    end
end
