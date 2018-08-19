require 'test_helper'

class CdAdmin::TutorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cd_admin_tutor = cd_admin_tutors(:one)
  end

  test "should get index" do
    get cd_admin_tutors_url
    assert_response :success
  end

  test "should get new" do
    get new_cd_admin_tutor_url
    assert_response :success
  end

  test "should create cd_admin_tutor" do
    assert_difference('CdAdmin::Tutor.count') do
      post cd_admin_tutors_url, params: { cd_admin_tutor: { currency: @cd_admin_tutor.currency, description: @cd_admin_tutor.description, highest_education: @cd_admin_tutor.highest_education, hour_rate: @cd_admin_tutor.hour_rate, place_of_work: @cd_admin_tutor.place_of_work, status: @cd_admin_tutor.status, teach_online: @cd_admin_tutor.teach_online, title: @cd_admin_tutor.title, user_id: @cd_admin_tutor.user_id } }
    end

    assert_redirected_to cd_admin_tutor_url(CdAdmin::Tutor.last)
  end

  test "should show cd_admin_tutor" do
    get cd_admin_tutor_url(@cd_admin_tutor)
    assert_response :success
  end

  test "should get edit" do
    get edit_cd_admin_tutor_url(@cd_admin_tutor)
    assert_response :success
  end

  test "should update cd_admin_tutor" do
    patch cd_admin_tutor_url(@cd_admin_tutor), params: { cd_admin_tutor: { currency: @cd_admin_tutor.currency, description: @cd_admin_tutor.description, highest_education: @cd_admin_tutor.highest_education, hour_rate: @cd_admin_tutor.hour_rate, place_of_work: @cd_admin_tutor.place_of_work, status: @cd_admin_tutor.status, teach_online: @cd_admin_tutor.teach_online, title: @cd_admin_tutor.title, user_id: @cd_admin_tutor.user_id } }
    assert_redirected_to cd_admin_tutor_url(@cd_admin_tutor)
  end

  test "should destroy cd_admin_tutor" do
    assert_difference('CdAdmin::Tutor.count', -1) do
      delete cd_admin_tutor_url(@cd_admin_tutor)
    end

    assert_redirected_to cd_admin_tutors_url
  end
end
