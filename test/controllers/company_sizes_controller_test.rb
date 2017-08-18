require 'test_helper'

class CompanySizesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company_size = company_sizes(:one)
  end

  test "should get index" do
    get company_sizes_url
    assert_response :success
  end

  test "should get new" do
    get new_company_size_url
    assert_response :success
  end

  test "should create company_size" do
    assert_difference('CompanySize.count') do
      post company_sizes_url, params: { company_size: { description: @company_size.description, name: @company_size.name } }
    end

    assert_redirected_to company_size_url(CompanySize.last)
  end

  test "should show company_size" do
    get company_size_url(@company_size)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_size_url(@company_size)
    assert_response :success
  end

  test "should update company_size" do
    patch company_size_url(@company_size), params: { company_size: { description: @company_size.description, name: @company_size.name } }
    assert_redirected_to company_size_url(@company_size)
  end

  test "should destroy company_size" do
    assert_difference('CompanySize.count', -1) do
      delete company_size_url(@company_size)
    end

    assert_redirected_to company_sizes_url
  end
end
