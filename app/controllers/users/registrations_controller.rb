class Users::RegistrationsController < Devise::RegistrationsController

  # GET /resource/change_general
  def edit
    render get_action
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource do |format|
        format.html {render :action => get_action}
      end
    else
      clean_up_passwords resource
      respond_with resource, :action => get_action
    end
  end

  protected

  def get_action
    case params['act']
      when 'password'
        return :change_password
      when 'contacts'
        return :change_contacts
      else
        return :change_general
    end
  end

  def update_resource(resource, params)
    if params['password'] || params['current_password']
      resource.update_with_password(params)
    else
      resource.update_without_password(params)
    end
  end
end
