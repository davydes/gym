class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    if resource.encrypted_password.blank?
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end
end
