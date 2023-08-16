require "test_helper"

class PublicacionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @publicacion = publicacions(:one)
  end

  test "should get index" do
    get publicacions_url
    assert_response :success
  end

  test "should get new" do
    get new_publicacion_url
    assert_response :success
  end

  test "should create publicacion" do
    assert_difference("Publicacion.count") do
      post publicacions_url, params: { publicacion: { content: @publicacion.content, title: @publicacion.title, user_id: @publicacion.user_id } }
    end

    assert_redirected_to publicacion_url(Publicacion.last)
  end

  test "should show publicacion" do
    get publicacion_url(@publicacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_publicacion_url(@publicacion)
    assert_response :success
  end

  test "should update publicacion" do
    patch publicacion_url(@publicacion), params: { publicacion: { content: @publicacion.content, title: @publicacion.title, user_id: @publicacion.user_id } }
    assert_redirected_to publicacion_url(@publicacion)
  end

  test "should destroy publicacion" do
    assert_difference("Publicacion.count", -1) do
      delete publicacion_url(@publicacion)
    end

    assert_redirected_to publicacions_url
  end
end
