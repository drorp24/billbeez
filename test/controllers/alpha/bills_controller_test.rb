require 'test_helper'

class Alpha::BillsControllerTest < ActionController::TestCase
  setup do
    @alpha_bill = alpha_bills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alpha_bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alpha_bill" do
    assert_difference('Alpha::Bill.count') do
      post :create, alpha_bill: { Amount: @alpha_bill.Amount, Id: @alpha_bill.Id, InvoiceDate: @alpha_bill.InvoiceDate, InvoiceNumber: @alpha_bill.InvoiceNumber, InvoicePeriodFrom: @alpha_bill.InvoicePeriodFrom, InvoicePeriodTo: @alpha_bill.InvoicePeriodTo, IsPaid: @alpha_bill.IsPaid, IsShown: @alpha_bill.IsShown, PayDate: @alpha_bill.PayDate, PayNumber: @alpha_bill.PayNumber, RemainderID: @alpha_bill.RemainderID, Remark: @alpha_bill.Remark, UploadDate: @alpha_bill.UploadDate, fileLocation1: @alpha_bill.fileLocation1, fileLocation2: @alpha_bill.fileLocation2, fileLocation3: @alpha_bill.fileLocation3, fileLocation4: @alpha_bill.fileLocation4, providername: @alpha_bill.providername }
    end

    assert_redirected_to alpha_bill_path(assigns(:alpha_bill))
  end

  test "should show alpha_bill" do
    get :show, id: @alpha_bill
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alpha_bill
    assert_response :success
  end

  test "should update alpha_bill" do
    patch :update, id: @alpha_bill, alpha_bill: { Amount: @alpha_bill.Amount, Id: @alpha_bill.Id, InvoiceDate: @alpha_bill.InvoiceDate, InvoiceNumber: @alpha_bill.InvoiceNumber, InvoicePeriodFrom: @alpha_bill.InvoicePeriodFrom, InvoicePeriodTo: @alpha_bill.InvoicePeriodTo, IsPaid: @alpha_bill.IsPaid, IsShown: @alpha_bill.IsShown, PayDate: @alpha_bill.PayDate, PayNumber: @alpha_bill.PayNumber, RemainderID: @alpha_bill.RemainderID, Remark: @alpha_bill.Remark, UploadDate: @alpha_bill.UploadDate, fileLocation1: @alpha_bill.fileLocation1, fileLocation2: @alpha_bill.fileLocation2, fileLocation3: @alpha_bill.fileLocation3, fileLocation4: @alpha_bill.fileLocation4, providername: @alpha_bill.providername }
    assert_redirected_to alpha_bill_path(assigns(:alpha_bill))
  end

  test "should destroy alpha_bill" do
    assert_difference('Alpha::Bill.count', -1) do
      delete :destroy, id: @alpha_bill
    end

    assert_redirected_to alpha_bills_path
  end
end
