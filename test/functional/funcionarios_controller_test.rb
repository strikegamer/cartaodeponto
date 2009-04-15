require 'test_helper'

class FuncionariosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:funcionarios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create funcionario" do
    assert_difference('Funcionario.count') do
      post :create, :funcionario => { }
    end

    assert_redirected_to funcionario_path(assigns(:funcionario))
  end

  test "should show funcionario" do
    get :show, :id => funcionarios(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => funcionarios(:one).id
    assert_response :success
  end

  test "should update funcionario" do
    put :update, :id => funcionarios(:one).id, :funcionario => { }
    assert_redirected_to funcionario_path(assigns(:funcionario))
  end

  test "should destroy funcionario" do
    assert_difference('Funcionario.count', -1) do
      delete :destroy, :id => funcionarios(:one).id
    end

    assert_redirected_to funcionarios_path
  end
end
