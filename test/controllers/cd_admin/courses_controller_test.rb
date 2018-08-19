require 'test_helper'

class CdAdmin::CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cd_admin_course = cd_admin_courses(:one)
  end

  test "should get index" do
    get cd_admin_courses_url
    assert_response :success
  end

  test "should get new" do
    get new_cd_admin_course_url
    assert_response :success
  end

  test "should create cd_admin_course" do
    assert_difference('CdAdmin::Course.count') do
      post cd_admin_courses_url, params: { cd_admin_course: { category_id: @cd_admin_course.category_id, city_id: @cd_admin_course.city_id, course_level_id: @cd_admin_course.course_level_id, cover_image: @cd_admin_course.cover_image, created_at: @cd_admin_course.created_at, description: @cd_admin_course.description, district_id: @cd_admin_course.district_id, is_active: @cd_admin_course.is_active, is_public: @cd_admin_course.is_public, location: @cd_admin_course.location, number_of_students: @cd_admin_course.number_of_students, period: @cd_admin_course.period, rating_count: @cd_admin_course.rating_count, rating_points: @cd_admin_course.rating_points, start_date: @cd_admin_course.start_date, status: @cd_admin_course.status, title: @cd_admin_course.title, tuition_fee: @cd_admin_course.tuition_fee, updated_at: @cd_admin_course.updated_at, user_id: @cd_admin_course.user_id, views: @cd_admin_course.views } }
    end

    assert_redirected_to cd_admin_course_url(CdAdmin::Course.last)
  end

  test "should show cd_admin_course" do
    get cd_admin_course_url(@cd_admin_course)
    assert_response :success
  end

  test "should get edit" do
    get edit_cd_admin_course_url(@cd_admin_course)
    assert_response :success
  end

  test "should update cd_admin_course" do
    patch cd_admin_course_url(@cd_admin_course), params: { cd_admin_course: { category_id: @cd_admin_course.category_id, city_id: @cd_admin_course.city_id, course_level_id: @cd_admin_course.course_level_id, cover_image: @cd_admin_course.cover_image, created_at: @cd_admin_course.created_at, description: @cd_admin_course.description, district_id: @cd_admin_course.district_id, is_active: @cd_admin_course.is_active, is_public: @cd_admin_course.is_public, location: @cd_admin_course.location, number_of_students: @cd_admin_course.number_of_students, period: @cd_admin_course.period, rating_count: @cd_admin_course.rating_count, rating_points: @cd_admin_course.rating_points, start_date: @cd_admin_course.start_date, status: @cd_admin_course.status, title: @cd_admin_course.title, tuition_fee: @cd_admin_course.tuition_fee, updated_at: @cd_admin_course.updated_at, user_id: @cd_admin_course.user_id, views: @cd_admin_course.views } }
    assert_redirected_to cd_admin_course_url(@cd_admin_course)
  end

  test "should destroy cd_admin_course" do
    assert_difference('CdAdmin::Course.count', -1) do
      delete cd_admin_course_url(@cd_admin_course)
    end

    assert_redirected_to cd_admin_courses_url
  end
end
