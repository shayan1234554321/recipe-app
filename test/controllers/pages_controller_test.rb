require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get foods' do
    get pages_foods_url
    assert_response :success
  end
end
