class SmackdownsController < ApplicationController
  before_action :set_smackdown, only: [:show, :edit, :update, :destroy]

  # GET /smackdowns
  # GET /smackdowns.json
  def index
    @smackdowns = Smackdown.all
  end

  # GET /smackdowns/1
  # GET /smackdowns/1.json
  def show
  end

  # GET /smackdowns/new
  def new
    @smackdown = Smackdown.new
  end

  # GET /smackdowns/1/edit
  def edit
  end

  # POST /smackdowns
  # POST /smackdowns.json
  def create
    @smackdown = Smackdown.new(smackdown_params)

    respond_to do |format|
      if @smackdown.save
        format.html { redirect_to @smackdown, notice: 'Smackdown was successfully created.' }
        format.json { render action: 'show', status: :created, location: @smackdown }
      else
        format.html { render action: 'new' }
        format.json { render json: @smackdown.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /smackdowns/1
  # PATCH/PUT /smackdowns/1.json
  def update
    respond_to do |format|
      if @smackdown.update(smackdown_params)
        format.html { redirect_to @smackdown, notice: 'Smackdown was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @smackdown.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /smackdowns/1
  # DELETE /smackdowns/1.json
  def destroy
    SmackdownRule.where(:smackdown_id => @smackdown.id).destroy_all
    @smackdown.destroy
    respond_to do |format|
      format.html { redirect_to smackdowns_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_smackdown
      @smackdown = Smackdown.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def smackdown_params
      params.require(:smackdown).permit(:player1_id, :player2_id, :judge1_id, :judge2_id, :judge1_winner_id, :judge2_winner_id, :player2_accepted, :judge1_accepted, :judge2_accepted, :judge1_comment, :judge2_comment)
    end
end
