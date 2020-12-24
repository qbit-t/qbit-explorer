require 'test_helper'

class ExplorerControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get blocks" do
    get :blocks
    assert_response :success
  end

  test "should get transactions" do
    get :transactions
    assert_response :success
  end

end
