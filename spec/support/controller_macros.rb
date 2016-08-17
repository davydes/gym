module ControllerMacros
  def login(options = {})
    include Devise::Test::ControllerHelpers
    before(:each) do
      role = options[:admin]||false ? :admin : :user
      user = FactoryGirl.create(role, confirmed_at: Time.zone.now)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end
  end
end