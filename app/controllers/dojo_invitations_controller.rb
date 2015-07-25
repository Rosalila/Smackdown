class DojoInvitationsController < ApplicationController
  before_action :set_dojo_invitation, only: [:show, :edit, :update, :destroy]

  # GET /dojo_invitations
  # GET /dojo_invitations.json
  def index
    @dojo_invitations = DojoInvitation.all
  end

  # GET /dojo_invitations/1
  # GET /dojo_invitations/1.json
  def show
  end

  # GET /dojo_invitations/new
  def new
    @dojo_invitation = DojoInvitation.new
  end

  # GET /dojo_invitations/1/edit
  def edit
  end

  # POST /dojo_invitations
  # POST /dojo_invitations.json
  def create
    @dojo_invitation = DojoInvitation.new(dojo_invitation_params)

    respond_to do |format|
      if @dojo_invitation.save
        format.html { redirect_to @dojo_invitation, notice: 'Dojo invitation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dojo_invitation }
      else
        format.html { render action: 'new' }
        format.json { render json: @dojo_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dojo_invitations/1
  # PATCH/PUT /dojo_invitations/1.json
  def update
    respond_to do |format|
      if @dojo_invitation.update(dojo_invitation_params)
        format.html { redirect_to @dojo_invitation, notice: 'Dojo invitation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dojo_invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dojo_invitations/1
  # DELETE /dojo_invitations/1.json
  def destroy
    @dojo_invitation.destroy
    respond_to do |format|
      format.html { redirect_to dojo_invitations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dojo_invitation
      @dojo_invitation = DojoInvitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dojo_invitation_params
      params.require(:dojo_invitation).permit(:user_id, :dojo_id, :admin_id)
    end
end
