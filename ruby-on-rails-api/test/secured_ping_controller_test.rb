require 'test_helper'

class SecuredPingControllerTest < ActionController::TestCase

  def with_a_valid_token
    @user = Struct.new('User', :id).new(1)
    @token = Knock::AuthToken.new(payload: { sub: @user.id }).token
    @request.env['HTTP_AUTHORIZATION'] = "Bearer #{@token}"
  end

  test 'responds with unauthorized' do
    get :ping
    assert_response :unauthorized
  end

  test 'responds with success with a valid token' do
    with_a_valid_token
    get :ping
    assert_response :success
  end

end
