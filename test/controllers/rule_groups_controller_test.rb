require 'test_helper'

class RuleGroupsControllerTest < ActionController::TestCase
  setup do
    @rule_group = rule_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rule_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rule_group" do
    assert_difference('RuleGroup.count') do
      post :create, rule_group: { game_id: @rule_group.game_id, name: @rule_group.name }
    end

    assert_redirected_to rule_group_path(assigns(:rule_group))
  end

  test "should show rule_group" do
    get :show, id: @rule_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rule_group
    assert_response :success
  end

  test "should update rule_group" do
    patch :update, id: @rule_group, rule_group: { game_id: @rule_group.game_id, name: @rule_group.name }
    assert_redirected_to rule_group_path(assigns(:rule_group))
  end

  test "should destroy rule_group" do
    assert_difference('RuleGroup.count', -1) do
      delete :destroy, id: @rule_group
    end

    assert_redirected_to rule_groups_path
  end
end
