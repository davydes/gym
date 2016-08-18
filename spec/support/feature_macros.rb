module FeatureMacros
  def login(options = {})
    include Warden::Test::Helpers
    before :each do
      role = options[:admin]||false ? :admin : :user
      user = FactoryGirl.create(role, confirmed_at: Time.zone.now)
      Warden.test_mode!
      login_as(user, scope: :user)
    end
    after :each do
      logout(:user)
      Warden.test_reset!
    end
  end
end