require 'test_helper'

class SmackdownsControllerTest < ActionController::TestCase
  setup do
    @smackdown = smackdowns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:smackdowns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create smackdown" do
    assert_difference('Smackdown.count') do
      post :create, smackdown: { judge1_accepted: @smackdown.judge1_accepted, judge1_comment: @smackdown.judge1_comment, judge1_id: @smackdown.judge1_id, judge1_winner_id: @smackdown.judge1_winner_id, judge2_accepted: @smackdown.judge2_accepted, judge2_comment: @smackdown.judge2_comment, judge2_id: @smackdown.judge2_id, judge2_winner_id: @smackdown.judge2_winner_id, player1_id: @smackdown.player1_id, player2_accepted: @smackdown.player2_accepted, player2_id: @smackdown.player2_id }
    end

    assert_redirected_to smackdown_path(assigns(:smackdown))
  end

  test "should show smackdown" do
    get :show, id: @smackdown
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @smackdown
    assert_response :success
  end

  test "should update smackdown" do
    patch :update, id: @smackdown, smackdown: { judge1_accepted: @smackdown.judge1_accepted, judge1_comment: @smackdown.judge1_comment, judge1_id: @smackdown.judge1_id, judge1_winner_id: @smackdown.judge1_winner_id, judge2_accepted: @smackdown.judge2_accepted, judge2_comment: @smackdown.judge2_comment, judge2_id: @smackdown.judge2_id, judge2_winner_id: @smackdown.judge2_winner_id, player1_id: @smackdown.player1_id, player2_accepted: @smackdown.player2_accepted, player2_id: @smackdown.player2_id }
    assert_redirected_to smackdown_path(assigns(:smackdown))
  end

  test "should destroy smackdown" do
    assert_difference('Smackdown.count', -1) do
      delete :destroy, id: @smackdown
    end

    assert_redirected_to smackdowns_path
  end
end
