require 'test_helper'

class DuesControllerTest < ActionController::TestCase
  setup do
    @due = dues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create due" do
    assert_difference('Due.count') do
      post :create, due: {  }
    end

    assert_redirected_to due_path(assigns(:due))
  end

  test "should show due" do
    get :show, id: @due
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @due
    assert_response :success
  end

  test "should update due" do
    patch :update, id: @due, due: {  }
    assert_redirected_to due_path(assigns(:due))
  end

  test "should destroy due" do
    assert_difference('Due.count', -1) do
      delete :destroy, id: @due
    end

    assert_redirected_to dues_path
  end
end
