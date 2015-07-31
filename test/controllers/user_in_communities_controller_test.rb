require 'test_helper'

class UserInCommunitiesControllerTest < ActionController::TestCase
  setup do
    @user_in_community = user_in_communities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_in_communities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_in_community" do
    assert_difference('UserInCommunity.count') do
      post :create, user_in_community: { community_id: @user_in_community.community_id, user_id: @user_in_community.user_id }
    end

    assert_redirected_to user_in_community_path(assigns(:user_in_community))
  end

  test "should show user_in_community" do
    get :show, id: @user_in_community
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_in_community
    assert_response :success
  end

  test "should update user_in_community" do
    patch :update, id: @user_in_community, user_in_community: { community_id: @user_in_community.community_id, user_id: @user_in_community.user_id }
    assert_redirected_to user_in_community_path(assigns(:user_in_community))
  end

  test "should destroy user_in_community" do
    assert_difference('UserInCommunity.count', -1) do
      delete :destroy, id: @user_in_community
    end

    assert_redirected_to user_in_communities_path
  end
end
