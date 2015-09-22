require 'test_helper'

class ArcanasControllerTest < ActionController::TestCase
  setup do
    @arcana = arcanas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:arcanas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create arcana" do
    assert_difference('Arcana.count') do
      post :create, arcana: { name: @arcana.name }
    end

    assert_redirected_to arcana_path(assigns(:arcana))
  end

  test "should show arcana" do
    get :show, id: @arcana
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @arcana
    assert_response :success
  end

  test "should update arcana" do
    patch :update, id: @arcana, arcana: { name: @arcana.name }
    assert_redirected_to arcana_path(assigns(:arcana))
  end

  test "should destroy arcana" do
    assert_difference('Arcana.count', -1) do
      delete :destroy, id: @arcana
    end

    assert_redirected_to arcanas_path
  end
end
