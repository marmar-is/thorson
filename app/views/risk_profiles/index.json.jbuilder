json.array!(@risk_profiles) do |risk_profile|
  json.extract! risk_profile, :id, :name, :county, :state, :effective, :retro, :specialty, :deductible, :limits, :limit_nas, :entity, :allied1, :allied2, :allied3, :sub_specialty
  json.url risk_profile_url(risk_profile, format: :json)
end
