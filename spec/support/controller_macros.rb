module ControllerMacros
  def login(options = {})
    before(:each) do
      role = options[:admin]||false ? :admin : :user
      user = FactoryGirl.create(role)
      user.confirmed_at = Time.zone.now
      user.save!

      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in user
    end
  end
end