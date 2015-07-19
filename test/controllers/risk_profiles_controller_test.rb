require 'test_helper'

class RiskProfilesControllerTest < ActionController::TestCase
  setup do
    @risk_profile = risk_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:risk_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create risk_profile" do
    assert_difference('RiskProfile.count') do
      post :create, risk_profile: { allied1: @risk_profile.allied1, allied2: @risk_profile.allied2, allied3: @risk_profile.allied3, county: @risk_profile.county, deductible: @risk_profile.deductible, effective: @risk_profile.effective, entity: @risk_profile.entity, limit_nas: @risk_profile.limit_nas, limits: @risk_profile.limits, name: @risk_profile.name, retro: @risk_profile.retro, specialty: @risk_profile.specialty, state: @risk_profile.state, sub_specialty: @risk_profile.sub_specialty }
    end

    assert_redirected_to risk_profile_path(assigns(:risk_profile))
  end

  test "should show risk_profile" do
    get :show, id: @risk_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @risk_profile
    assert_response :success
  end

  test "should update risk_profile" do
    patch :update, id: @risk_profile, risk_profile: { allied1: @risk_profile.allied1, allied2: @risk_profile.allied2, allied3: @risk_profile.allied3, county: @risk_profile.county, deductible: @risk_profile.deductible, effective: @risk_profile.effective, entity: @risk_profile.entity, limit_nas: @risk_profile.limit_nas, limits: @risk_profile.limits, name: @risk_profile.name, retro: @risk_profile.retro, specialty: @risk_profile.specialty, state: @risk_profile.state, sub_specialty: @risk_profile.sub_specialty }
    assert_redirected_to risk_profile_path(assigns(:risk_profile))
  end

  test "should destroy risk_profile" do
    assert_difference('RiskProfile.count', -1) do
      delete :destroy, id: @risk_profile
    end

    assert_redirected_to risk_profiles_path
  end
end
