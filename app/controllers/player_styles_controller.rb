class PlayerStylesController < ApplicationController
  before_action :set_player_style, only: [:show, :edit, :update, :destroy]

  # GET /player_styles
  # GET /player_styles.json
  def index
    @player_styles = PlayerStyle.all
  end

  # GET /player_styles/1
  # GET /player_styles/1.json
  def show
  end

  # GET /player_styles/new
  def new
    @player_style = PlayerStyle.new
  end

  # GET /player_styles/1/edit
  def edit
  end

  # POST /player_styles
  # POST /player_styles.json
  def create
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @player_style = PlayerStyle.new(player_style_params)

    respond_to do |format|
      if @player_style.save
        format.html { redirect_to @player_style, notice: 'Player style was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player_style }
      else
        format.html { render action: 'new' }
        format.json { render json: @player_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_styles/1
  # PATCH/PUT /player_styles/1.json
  def update
    if !userIsAdmin
      redirect_to "/"
      return
    end
    respond_to do |format|
      if @player_style.update(player_style_params)
        format.html { redirect_to @player_style, notice: 'Player style was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_styles/1
  # DELETE /player_styles/1.json
  def destroy
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @player_style.destroy
    respond_to do |format|
      format.html { redirect_to player_styles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_style
      @player_style = PlayerStyle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_style_params
      params.require(:player_style).permit(:name, :image, :description, :long_description_link)
    end
end
