class UserPlayingGamesController < ApplicationController
  before_action :set_user_playing_game, only: [:show, :edit, :update, :destroy]

  # GET /user_playing_games
  # GET /user_playing_games.json
  def index
    if !userIsAdmin
      redirect_to "/"
      return
    end

    @user_playing_games = UserPlayingGame.all
  end

  # GET /user_playing_games/1
  # GET /user_playing_games/1.json
  def show
    if !userIsAdmin
      redirect_to "/"
      return
    end
  end

  # GET /user_playing_games/new
  def new
    if !userIsAdmin
      redirect_to "/"
      return
    end

    @user_playing_game = UserPlayingGame.new
  end

  # GET /user_playing_games/1/edit
  def edit
    if !userIsAdmin
      redirect_to "/"
      return
    end
  end

  # POST /user_playing_games
  # POST /user_playing_games.json
  def create
    if !userIsAdmin
      redirect_to "/"
      return
    end

    @user_playing_game = UserPlayingGame.new(user_playing_game_params)

    respond_to do |format|
      if @user_playing_game.save
        format.html { redirect_to "/home/profile", notice: 'User playing game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_playing_game }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_playing_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_playing_games/1
  # PATCH/PUT /user_playing_games/1.json
  def update
    if !userIsAdmin
      redirect_to "/"
      return
    end

    new_is_playing = !@user_playing_game.is_playing
    respond_to do |format|
      if @user_playing_game.update(user_playing_game_params)
        @user_playing_game.is_playing = new_is_playing
        @user_playing_game.save
        format.html { redirect_to "/home/profile", notice: 'User playing game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_playing_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_playing_games/1
  # DELETE /user_playing_games/1.json
  def destroy
    if !userIsAdmin
      redirect_to "/"
      return
    end

    @user_playing_game.destroy
    respond_to do |format|
      format.html { redirect_to user_playing_games_url }
      format.json { head :no_content }
    end
  end

  def play_game
    game_id = params[:game_id]
    upg = UserPlayingGame.where(:user_id=>current_user.id, :game_id=>game_id)[0]
    if upg==nil
      upg = UserPlayingGame.new
    end
    upg.is_playing = true
    upg.save
    redirect_to "/home/profile"
  end


  def stop_playing_game
    game_id = params[:game_id]
    upg = UserPlayingGame.where(:user_id=>current_user.id, :game_id=>game_id)[0]
    if upg==nil
      upg = UserPlayingGame.new
    end
    upg.is_playing = false
    upg.save
    redirect_to "/home/profile"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_playing_game
      @user_playing_game = UserPlayingGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_playing_game_params
      params.require(:user_playing_game).permit(:user_id, :game_id, :is_playing)
    end
end
