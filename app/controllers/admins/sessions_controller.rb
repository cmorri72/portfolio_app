class Admins::SessionsController < Devise::SessionsController
  # Redirect to admin dashboard after signing in
  def after_sign_in_path_for(resource)
    root_path
  end

  # Redirect to admin login page after signing out
  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path
  end

  def create
    Rails.logger.info "Login params: #{params.inspect}"
    super
  end
end
