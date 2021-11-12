require "test_helper"

class StaticsControllerTest < ActionDispatch::IntegrationTest
  test "should get coming" do
    get statics_coming_url
    assert_response :success
  end
end
