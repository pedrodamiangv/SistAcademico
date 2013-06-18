require 'test_helper'

class CalificacionesControllerTest < ActionController::TestCase
  setup do
    @calificacion = calificaciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calificaciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calificacion" do
    assert_difference('Calificacion.count') do
      post :create, calificacion: { alumno_id: @calificacion.alumno_id, calificacion: @calificacion.calificacion, materia_id: @calificacion.materia_id, puntos_correctos: @calificacion.puntos_correctos, total_puntos: @calificacion.total_puntos }
    end

    assert_redirected_to calificacion_path(assigns(:calificacion))
  end

  test "should show calificacion" do
    get :show, id: @calificacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @calificacion
    assert_response :success
  end

  test "should update calificacion" do
    put :update, id: @calificacion, calificacion: { alumno_id: @calificacion.alumno_id, calificacion: @calificacion.calificacion, materia_id: @calificacion.materia_id, puntos_correctos: @calificacion.puntos_correctos, total_puntos: @calificacion.total_puntos }
    assert_redirected_to calificacion_path(assigns(:calificacion))
  end

  test "should destroy calificacion" do
    assert_difference('Calificacion.count', -1) do
      delete :destroy, id: @calificacion
    end

    assert_redirected_to calificaciones_path
  end
end
