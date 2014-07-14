require 'test_helper'

class UserPlayingGamesControllerTest < ActionController::TestCase
  setup do
    @user_playing_game = user_playing_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_playing_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_playing_game" do
    assert_difference('UserPlayingGame.count') do
      post :create, user_playing_game: { game_id: @user_playing_game.game_id, is_playing: @user_playing_game.is_playing, user_id: @user_playing_game.user_id }
    end

    assert_redirected_to user_playing_game_path(assigns(:user_playing_game))
  end

  test "should show user_playing_game" do
    get :show, id: @user_playing_game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_playing_game
    assert_response :success
  end

  test "should update user_playing_game" do
    patch :update, id: @user_playing_game, user_playing_game: { game_id: @user_playing_game.game_id, is_playing: @user_playing_game.is_playing, user_id: @user_playing_game.user_id }
    assert_redirected_to user_playing_game_path(assigns(:user_playing_game))
  end

  test "should destroy user_playing_game" do
    assert_difference('UserPlayingGame.count', -1) do
      delete :destroy, id: @user_playing_game
    end

    assert_redirected_to user_playing_games_path
  end
end
