require 'test_helper'

class PlanificacionesControllerTest < ActionController::TestCase
  setup do
    @planificacion = planificaciones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planificaciones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create planificacion" do
    assert_difference('Planificacion.count') do
      post :create, planificacion: { curso_id: @planificacion.curso_id, descripcion: @planificacion.descripcion, etapa: @planificacion.etapa, fecha_entrega: @planificacion.fecha_entrega, materia_id: @planificacion.materia_id, tarea: @planificacion.tarea, total_puntos: @planificacion.total_puntos }
    end

    assert_redirected_to planificacion_path(assigns(:planificacion))
  end

  test "should show planificacion" do
    get :show, id: @planificacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @planificacion
    assert_response :success
  end

  test "should update planificacion" do
    put :update, id: @planificacion, planificacion: { curso_id: @planificacion.curso_id, descripcion: @planificacion.descripcion, etapa: @planificacion.etapa, fecha_entrega: @planificacion.fecha_entrega, materia_id: @planificacion.materia_id, tarea: @planificacion.tarea, total_puntos: @planificacion.total_puntos }
    assert_redirected_to planificacion_path(assigns(:planificacion))
  end

  test "should destroy planificacion" do
    assert_difference('Planificacion.count', -1) do
      delete :destroy, id: @planificacion
    end

    assert_redirected_to planificaciones_path
  end
end
