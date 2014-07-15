class SmackdownRulesController < ApplicationController
  before_action :set_smackdown_rule, only: [:show, :edit, :update, :destroy]

  # GET /smackdown_rules
  # GET /smackdown_rules.json
  def index
    @smackdown_rules = SmackdownRule.all
  end

  # GET /smackdown_rules/1
  # GET /smackdown_rules/1.json
  def show
  end

  # GET /smackdown_rules/new
  def new
    @smackdown_rule = SmackdownRule.new
  end

  # GET /smackdown_rules/1/edit
  def edit
  end

  # POST /smackdown_rules
  # POST /smackdown_rules.json
  def create
    @smackdown_rule = SmackdownRule.new(smackdown_rule_params)

    respond_to do |format|
      if @smackdown_rule.save
        format.html { redirect_to @smackdown_rule, notice: 'Smackdown rule was successfully created.' }
        format.json { render action: 'show', status: :created, location: @smackdown_rule }
      else
        format.html { render action: 'new' }
        format.json { render json: @smackdown_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /smackdown_rules/1
  # PATCH/PUT /smackdown_rules/1.json
  def update
    respond_to do |format|
      if @smackdown_rule.update(smackdown_rule_params)
        format.html { redirect_to @smackdown_rule, notice: 'Smackdown rule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @smackdown_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /smackdown_rules/1
  # DELETE /smackdown_rules/1.json
  def destroy
    @smackdown_rule.destroy
    respond_to do |format|
      format.html { redirect_to smackdown_rules_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_smackdown_rule
      @smackdown_rule = SmackdownRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def smackdown_rule_params
      params.require(:smackdown_rule).permit(:smackdown_id, :rule_id)
    end
end
