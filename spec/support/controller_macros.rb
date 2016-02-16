module ControllerMacros
  def login_user(options = {})
    options[:admin] ||= false

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(options[:admin] ? :admin : :user)
      user.confirmed_at = Time.zone.now
      user.save!
      sign_in user
    end
  end
end