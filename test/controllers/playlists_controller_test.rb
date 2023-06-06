require "test_helper"

class PlaylistsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get playlists_new_url
    assert_response :success
  end
end
