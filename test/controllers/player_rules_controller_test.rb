require 'test_helper'

class PlayerRulesControllerTest < ActionController::TestCase
  setup do
    @player_rule = player_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:player_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player_rule" do
    assert_difference('PlayerRule.count') do
      post :create, player_rule: { activated: @player_rule.activated, rule_id: @player_rule.rule_id, user_id: @player_rule.user_id }
    end

    assert_redirected_to player_rule_path(assigns(:player_rule))
  end

  test "should show player_rule" do
    get :show, id: @player_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @player_rule
    assert_response :success
  end

  test "should update player_rule" do
    patch :update, id: @player_rule, player_rule: { activated: @player_rule.activated, rule_id: @player_rule.rule_id, user_id: @player_rule.user_id }
    assert_redirected_to player_rule_path(assigns(:player_rule))
  end

  test "should destroy player_rule" do
    assert_difference('PlayerRule.count', -1) do
      delete :destroy, id: @player_rule
    end

    assert_redirected_to player_rules_path
  end
end
