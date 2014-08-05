require 'test_helper'

class MetaImagesControllerTest < ActionController::TestCase
  setup do
    @meta_image = meta_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meta_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meta_image" do
    assert_difference('MetaImage.count') do
      post :create, meta_image: { path: @meta_image.path }
    end

    assert_redirected_to meta_image_path(assigns(:meta_image))
  end

  test "should show meta_image" do
    get :show, id: @meta_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meta_image
    assert_response :success
  end

  test "should update meta_image" do
    patch :update, id: @meta_image, meta_image: { path: @meta_image.path }
    assert_redirected_to meta_image_path(assigns(:meta_image))
  end

  test "should destroy meta_image" do
    assert_difference('MetaImage.count', -1) do
      delete :destroy, id: @meta_image
    end

    assert_redirected_to meta_images_path
  end
end
