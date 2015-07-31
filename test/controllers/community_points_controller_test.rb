require 'test_helper'

class CommunityPointsControllerTest < ActionController::TestCase
  setup do
    @community_point = community_points(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:community_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create community_point" do
    assert_difference('CommunityPoint.count') do
      post :create, community_point: { community_id: @community_point.community_id, latitude: @community_point.latitude, longitude: @community_point.longitude }
    end

    assert_redirected_to community_point_path(assigns(:community_point))
  end

  test "should show community_point" do
    get :show, id: @community_point
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @community_point
    assert_response :success
  end

  test "should update community_point" do
    patch :update, id: @community_point, community_point: { community_id: @community_point.community_id, latitude: @community_point.latitude, longitude: @community_point.longitude }
    assert_redirected_to community_point_path(assigns(:community_point))
  end

  test "should destroy community_point" do
    assert_difference('CommunityPoint.count', -1) do
      delete :destroy, id: @community_point
    end

    assert_redirected_to community_points_path
  end
end
