require 'test_helper'

class UserInDojosControllerTest < ActionController::TestCase
  setup do
    @user_in_dojo = user_in_dojos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_in_dojos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_in_dojo" do
    assert_difference('UserInDojo.count') do
      post :create, user_in_dojo: { dojo_id: @user_in_dojo.dojo_id, is_admin: @user_in_dojo.is_admin, user_id: @user_in_dojo.user_id }
    end

    assert_redirected_to user_in_dojo_path(assigns(:user_in_dojo))
  end

  test "should show user_in_dojo" do
    get :show, id: @user_in_dojo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_in_dojo
    assert_response :success
  end

  test "should update user_in_dojo" do
    patch :update, id: @user_in_dojo, user_in_dojo: { dojo_id: @user_in_dojo.dojo_id, is_admin: @user_in_dojo.is_admin, user_id: @user_in_dojo.user_id }
    assert_redirected_to user_in_dojo_path(assigns(:user_in_dojo))
  end

  test "should destroy user_in_dojo" do
    assert_difference('UserInDojo.count', -1) do
      delete :destroy, id: @user_in_dojo
    end

    assert_redirected_to user_in_dojos_path
  end
end
