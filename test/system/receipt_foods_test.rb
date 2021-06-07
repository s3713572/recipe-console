require "application_system_test_case"

class ReceiptFoodsTest < ApplicationSystemTestCase
  setup do
    @receipt_food = receipt_foods(:one)
  end

  test "visiting the index" do
    visit receipt_foods_url
    assert_selector "h1", text: "Receipt Foods"
  end

  test "creating a Receipt food" do
    visit receipt_foods_url
    click_on "New Receipt Food"

    fill_in "Count", with: @receipt_food.count
    fill_in "Food", with: @receipt_food.food
    fill_in "Receipt", with: @receipt_food.receipt
    fill_in "Unit", with: @receipt_food.unit
    click_on "Create Receipt food"

    assert_text "Receipt food was successfully created"
    click_on "Back"
  end

  test "updating a Receipt food" do
    visit receipt_foods_url
    click_on "Edit", match: :first

    fill_in "Count", with: @receipt_food.count
    fill_in "Food", with: @receipt_food.food
    fill_in "Receipt", with: @receipt_food.receipt
    fill_in "Unit", with: @receipt_food.unit
    click_on "Update Receipt food"

    assert_text "Receipt food was successfully updated"
    click_on "Back"
  end

  test "destroying a Receipt food" do
    visit receipt_foods_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Receipt food was successfully destroyed"
  end
end
