class UserInDojosController < ApplicationController
  before_action :set_user_in_dojo, only: [:show, :edit, :update, :destroy]

  # GET /user_in_dojos
  # GET /user_in_dojos.json
  def index
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @user_in_dojos = UserInDojo.all
  end

  # GET /user_in_dojos/1
  # GET /user_in_dojos/1.json
  def show
    if !userIsAdmin
      redirect_to "/"
      return
    end
  end

  # GET /user_in_dojos/new
  def new
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @user_in_dojo = UserInDojo.new
  end

  # GET /user_in_dojos/1/edit
  def edit
    if !userIsAdmin
      redirect_to "/"
      return
    end
  end

  # POST /user_in_dojos
  # POST /user_in_dojos.json
  def create
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @user_in_dojo = UserInDojo.new(user_in_dojo_params)

    respond_to do |format|
      if @user_in_dojo.save
        format.html { redirect_to @user_in_dojo, notice: 'User in dojo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_in_dojo }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_in_dojo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_in_dojos/1
  # PATCH/PUT /user_in_dojos/1.json
  def update
    if !userIsAdmin
      redirect_to "/"
      return
    end
    respond_to do |format|
      if @user_in_dojo.update(user_in_dojo_params)
        format.html { redirect_to @user_in_dojo, notice: 'User in dojo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_in_dojo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_in_dojos/1
  # DELETE /user_in_dojos/1.json
  def destroy
    if !userIsAdmin
      redirect_to "/"
      return
    end
    @user_in_dojo.destroy
    respond_to do |format|
      format.html { redirect_to user_in_dojos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_in_dojo
      @user_in_dojo = UserInDojo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_in_dojo_params
      params.require(:user_in_dojo).permit(:user_id, :dojo_id, :is_admin)
    end
end
