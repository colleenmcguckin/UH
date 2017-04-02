class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if resource.receiver?
      verify_receiver_path resource
    elsif resource.donor?
      edit_donor_path resource
    end
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
