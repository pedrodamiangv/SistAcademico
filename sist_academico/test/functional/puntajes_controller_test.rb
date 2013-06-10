require 'test_helper'

class PuntajesControllerTest < ActionController::TestCase
  setup do
    @puntaje = puntajes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:puntajes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create puntaje" do
    assert_difference('Puntaje.count') do
      post :create, puntaje: { alumno_id: @puntaje.alumno_id, descripcion: @puntaje.descripcion, puntaje: @puntaje.puntaje, tarea_id: @puntaje.tarea_id }
    end

    assert_redirected_to puntaje_path(assigns(:puntaje))
  end

  test "should show puntaje" do
    get :show, id: @puntaje
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @puntaje
    assert_response :success
  end

  test "should update puntaje" do
    put :update, id: @puntaje, puntaje: { alumno_id: @puntaje.alumno_id, descripcion: @puntaje.descripcion, puntaje: @puntaje.puntaje, tarea_id: @puntaje.tarea_id }
    assert_redirected_to puntaje_path(assigns(:puntaje))
  end

  test "should destroy puntaje" do
    assert_difference('Puntaje.count', -1) do
      delete :destroy, id: @puntaje
    end

    assert_redirected_to puntajes_path
  end
end
