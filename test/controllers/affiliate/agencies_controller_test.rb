require 'test_helper'

class Affiliate::AgenciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @affiliate_agency = affiliate_agencies(:one)
  end

  test "should get index" do
    get affiliate_agencies_url
    assert_response :success
  end

  test "should get new" do
    get new_affiliate_agency_url
    assert_response :success
  end

  test "should create affiliate_agency" do
    assert_difference('Affiliate::Agency.count') do
      post affiliate_agencies_url, params: { affiliate_agency: { address: @affiliate_agency.address, description: @affiliate_agency.description, domain: @affiliate_agency.domain, name: @affiliate_agency.name, phone: @affiliate_agency.phone, user_id: @affiliate_agency.user_id } }
    end

    assert_redirected_to affiliate_agency_url(Affiliate::Agency.last)
  end

  test "should show affiliate_agency" do
    get affiliate_agency_url(@affiliate_agency)
    assert_response :success
  end

  test "should get edit" do
    get edit_affiliate_agency_url(@affiliate_agency)
    assert_response :success
  end

  test "should update affiliate_agency" do
    patch affiliate_agency_url(@affiliate_agency), params: { affiliate_agency: { address: @affiliate_agency.address, description: @affiliate_agency.description, domain: @affiliate_agency.domain, name: @affiliate_agency.name, phone: @affiliate_agency.phone, user_id: @affiliate_agency.user_id } }
    assert_redirected_to affiliate_agency_url(@affiliate_agency)
  end

  test "should destroy affiliate_agency" do
    assert_difference('Affiliate::Agency.count', -1) do
      delete affiliate_agency_url(@affiliate_agency)
    end

    assert_redirected_to affiliate_agencies_url
  end
end
