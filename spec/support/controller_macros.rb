module ControllerMacros
  def login(options = {})
    options[:admin] ||= false

    before(:each) do
      role = options[:admin] ? :admin : :user
      @request.env["devise.mapping"] = Devise.mappings[role]
      user = FactoryGirl.create(role)
      user.confirmed_at = Time.zone.now
      user.save!
      sign_in user
    end
  end
end