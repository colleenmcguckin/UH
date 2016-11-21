class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    if resource.receiver?
      verify_receiver_path resource
    end
  end
end
