require 'test_helper'

class PlayerStylesControllerTest < ActionController::TestCase
  setup do
    @player_style = player_styles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:player_styles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player_style" do
    assert_difference('PlayerStyle.count') do
      post :create, player_style: { description: @player_style.description, image: @player_style.image, long_description_link: @player_style.long_description_link, name: @player_style.name }
    end

    assert_redirected_to player_style_path(assigns(:player_style))
  end

  test "should show player_style" do
    get :show, id: @player_style
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @player_style
    assert_response :success
  end

  test "should update player_style" do
    patch :update, id: @player_style, player_style: { description: @player_style.description, image: @player_style.image, long_description_link: @player_style.long_description_link, name: @player_style.name }
    assert_redirected_to player_style_path(assigns(:player_style))
  end

  test "should destroy player_style" do
    assert_difference('PlayerStyle.count', -1) do
      delete :destroy, id: @player_style
    end

    assert_redirected_to player_styles_path
  end
end
