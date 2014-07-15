require 'test_helper'

class SmackdownRulesControllerTest < ActionController::TestCase
  setup do
    @smackdown_rule = smackdown_rules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:smackdown_rules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create smackdown_rule" do
    assert_difference('SmackdownRule.count') do
      post :create, smackdown_rule: { rule_id: @smackdown_rule.rule_id, smackdown_id: @smackdown_rule.smackdown_id }
    end

    assert_redirected_to smackdown_rule_path(assigns(:smackdown_rule))
  end

  test "should show smackdown_rule" do
    get :show, id: @smackdown_rule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @smackdown_rule
    assert_response :success
  end

  test "should update smackdown_rule" do
    patch :update, id: @smackdown_rule, smackdown_rule: { rule_id: @smackdown_rule.rule_id, smackdown_id: @smackdown_rule.smackdown_id }
    assert_redirected_to smackdown_rule_path(assigns(:smackdown_rule))
  end

  test "should destroy smackdown_rule" do
    assert_difference('SmackdownRule.count', -1) do
      delete :destroy, id: @smackdown_rule
    end

    assert_redirected_to smackdown_rules_path
  end
end
