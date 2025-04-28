require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:one)
    sign_in @user1

    @transaction1 = transactions(:one)
  end

  test "should get index" do
    get transactions_path(locale: I18n.default_locale)
    assert_response :success
  end

  test "should get new" do
    get new_transaction_path
    assert_response :success
  end
end
