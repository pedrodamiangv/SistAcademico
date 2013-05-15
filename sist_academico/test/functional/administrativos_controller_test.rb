require 'test_helper'

class AdministrativosControllerTest < ActionController::TestCase
  setup do
    @administrativo = administrativos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administrativos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administrativo" do
    assert_difference('Administrativo.count') do
      post :create, administrativo: { cargo: @administrativo.cargo, user_id: @administrativo.user_id }
    end

    assert_redirected_to administrativo_path(assigns(:administrativo))
  end

  test "should show administrativo" do
    get :show, id: @administrativo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administrativo
    assert_response :success
  end

  test "should update administrativo" do
    put :update, id: @administrativo, administrativo: { cargo: @administrativo.cargo, user_id: @administrativo.user_id }
    assert_redirected_to administrativo_path(assigns(:administrativo))
  end

  test "should destroy administrativo" do
    assert_difference('Administrativo.count', -1) do
      delete :destroy, id: @administrativo
    end

    assert_redirected_to administrativos_path
  end
end
