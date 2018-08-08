require 'test_helper'

class GuestControllerTest < ActionDispatch::IntegrationTest
  test "should get create,read,update,delete" do
    get guest_create,read,update,delete_url
    assert_response :success
  end

end
