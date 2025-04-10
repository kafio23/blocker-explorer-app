require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url

    assert_equal "index", @controller.action_name
    assert_response :success

    assert_equal 1, assigns(:transactions).size
  end
end
