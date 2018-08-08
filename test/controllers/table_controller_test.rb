require 'test_helper'

class TableControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get table_index_url
    assert_response :success
  end

  test "should get new" do
    get table_new_url
    assert_response :success
  end

  test "should get create" do
    get table_create_url
    assert_response :success
  end

  test "should get destroy" do
    get table_destroy_url
    assert_response :success
  end

end
