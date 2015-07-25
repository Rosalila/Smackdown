require 'test_helper'

class DojoInvitationsControllerTest < ActionController::TestCase
  setup do
    @dojo_invitation = dojo_invitations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dojo_invitations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dojo_invitation" do
    assert_difference('DojoInvitation.count') do
      post :create, dojo_invitation: { admin_id: @dojo_invitation.admin_id, dojo_id: @dojo_invitation.dojo_id, user_id: @dojo_invitation.user_id }
    end

    assert_redirected_to dojo_invitation_path(assigns(:dojo_invitation))
  end

  test "should show dojo_invitation" do
    get :show, id: @dojo_invitation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dojo_invitation
    assert_response :success
  end

  test "should update dojo_invitation" do
    patch :update, id: @dojo_invitation, dojo_invitation: { admin_id: @dojo_invitation.admin_id, dojo_id: @dojo_invitation.dojo_id, user_id: @dojo_invitation.user_id }
    assert_redirected_to dojo_invitation_path(assigns(:dojo_invitation))
  end

  test "should destroy dojo_invitation" do
    assert_difference('DojoInvitation.count', -1) do
      delete :destroy, id: @dojo_invitation
    end

    assert_redirected_to dojo_invitations_path
  end
end
