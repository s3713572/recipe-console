require "test_helper"

class ReceiptFoodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @receipt_food = receipt_foods(:one)
  end

  test "should get index" do
    get receipt_foods_url
    assert_response :success
  end

  test "should get new" do
    get new_receipt_food_url
    assert_response :success
  end

  test "should create receipt_food" do
    assert_difference('ReceiptFood.count') do
      post receipt_foods_url, params: { receipt_food: { count: @receipt_food.count, food: @receipt_food.food, receipt: @receipt_food.receipt, unit: @receipt_food.unit } }
    end

    assert_redirected_to receipt_food_url(ReceiptFood.last)
  end

  test "should show receipt_food" do
    get receipt_food_url(@receipt_food)
    assert_response :success
  end

  test "should get edit" do
    get edit_receipt_food_url(@receipt_food)
    assert_response :success
  end

  test "should update receipt_food" do
    patch receipt_food_url(@receipt_food), params: { receipt_food: { count: @receipt_food.count, food: @receipt_food.food, receipt: @receipt_food.receipt, unit: @receipt_food.unit } }
    assert_redirected_to receipt_food_url(@receipt_food)
  end

  test "should destroy receipt_food" do
    assert_difference('ReceiptFood.count', -1) do
      delete receipt_food_url(@receipt_food)
    end

    assert_redirected_to receipt_foods_url
  end
end
