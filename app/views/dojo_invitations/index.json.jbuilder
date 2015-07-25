json.array!(@dojo_invitations) do |dojo_invitation|
  json.extract! dojo_invitation, :id, :user_id, :dojo_id, :admin_id
  json.url dojo_invitation_url(dojo_invitation, format: :json)
end
