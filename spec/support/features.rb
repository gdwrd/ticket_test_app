RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Features::RegistrationHelpers, type: :feature
end