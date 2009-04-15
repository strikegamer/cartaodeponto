require 'test_helper'

class MarcacaopontosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:marcacaopontos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create marcacaoponto" do
    assert_difference('Marcacaoponto.count') do
      post :create, :marcacaoponto => { }
    end

    assert_redirected_to marcacaoponto_path(assigns(:marcacaoponto))
  end

  test "should show marcacaoponto" do
    get :show, :id => marcacaopontos(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => marcacaopontos(:one).id
    assert_response :success
  end

  test "should update marcacaoponto" do
    put :update, :id => marcacaopontos(:one).id, :marcacaoponto => { }
    assert_redirected_to marcacaoponto_path(assigns(:marcacaoponto))
  end

  test "should destroy marcacaoponto" do
    assert_difference('Marcacaoponto.count', -1) do
      delete :destroy, :id => marcacaopontos(:one).id
    end

    assert_redirected_to marcacaopontos_path
  end
end
