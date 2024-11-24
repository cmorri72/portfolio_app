# frozen_string_literal: true

class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def create
    Rails.logger.info "Parameters: #{params.inspect}" # Debugging output
    super
  end
end
