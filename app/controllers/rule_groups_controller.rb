class RuleGroupsController < ApplicationController
  before_action :set_rule_group, only: [:show, :edit, :update, :destroy]

  # GET /rule_groups
  # GET /rule_groups.json
  def index
    if !userIsAdmin
      redirect_to "/"
      return
    end

    @rule_groups = RuleGroup.all
  end

  # GET /rule_groups/1
  # GET /rule_groups/1.json
  def show
    if !userIsAdmin
      redirect_to "/"
      return
    end
  end

  # GET /rule_groups/new
  def new
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @rule_group = RuleGroup.new
  end

  # GET /rule_groups/1/edit
  def edit
    if !userIsAdmin
      redirect_to "/"
      return
    end
  end

  # POST /rule_groups
  # POST /rule_groups.json
  def create
    if !userIsAdmin
      redirect_to "/"
      return
    end

    @rule_group = RuleGroup.new(rule_group_params)

    respond_to do |format|
      if @rule_group.save
        format.html { redirect_to @rule_group, notice: 'Rule group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rule_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @rule_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rule_groups/1
  # PATCH/PUT /rule_groups/1.json
  def update
    if !userIsAdmin
      redirect_to "/"
      return
    end

    respond_to do |format|
      if @rule_group.update(rule_group_params)
        format.html { redirect_to @rule_group, notice: 'Rule group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rule_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rule_groups/1
  # DELETE /rule_groups/1.json
  def destroy
    if !userIsAdmin
      redirect_to "/"
      return
    end

    @rule_group.destroy
    respond_to do |format|
      format.html { redirect_to rule_groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule_group
      @rule_group = RuleGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rule_group_params
      params.require(:rule_group).permit(:game_id, :name)
    end
end
