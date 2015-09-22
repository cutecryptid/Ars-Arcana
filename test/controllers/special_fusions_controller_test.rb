require 'test_helper'

class SpecialFusionsControllerTest < ActionController::TestCase
  setup do
    @special_fusion = special_fusions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:special_fusions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create special_fusion" do
    assert_difference('SpecialFusion.count') do
      post :create, special_fusion: { persona_id: @special_fusion.persona_id }
    end

    assert_redirected_to special_fusion_path(assigns(:special_fusion))
  end

  test "should show special_fusion" do
    get :show, id: @special_fusion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @special_fusion
    assert_response :success
  end

  test "should update special_fusion" do
    patch :update, id: @special_fusion, special_fusion: { persona_id: @special_fusion.persona_id }
    assert_redirected_to special_fusion_path(assigns(:special_fusion))
  end

  test "should destroy special_fusion" do
    assert_difference('SpecialFusion.count', -1) do
      delete :destroy, id: @special_fusion
    end

    assert_redirected_to special_fusions_path
  end
end
