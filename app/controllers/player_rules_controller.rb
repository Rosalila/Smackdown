class PlayerRulesController < ApplicationController
  before_action :set_player_rule, only: [:show, :edit, :update, :destroy]

  # GET /player_rules
  # GET /player_rules.json
  def index
    @player_rules = PlayerRule.all
  end

  # GET /player_rules/1
  # GET /player_rules/1.json
  def show
  end

  # GET /player_rules/new
  def new
    @player_rule = PlayerRule.new
  end

  # GET /player_rules/1/edit
  def edit
  end

  # POST /player_rules
  # POST /player_rules.json
  def create
    @player_rule = PlayerRule.new(player_rule_params)

    respond_to do |format|
      if @player_rule.save
        format.html { redirect_to "/", notice: 'Player rule was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player_rule }
      else
        format.html { render action: 'new' }
        format.json { render json: @player_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_rules/1
  # PATCH/PUT /player_rules/1.json
  def update
    respond_to do |format|
      if @player_rule.update(player_rule_params)
        format.html { redirect_to "/", notice: 'Player rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_rules/1
  # DELETE /player_rules/1.json
  def destroy
    @player_rule.destroy
    respond_to do |format|
      format.html { redirect_to player_rules_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_rule
      @player_rule = PlayerRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_rule_params
      params.require(:player_rule).permit(:rule_id, :user_id, :activated)
    end
end
