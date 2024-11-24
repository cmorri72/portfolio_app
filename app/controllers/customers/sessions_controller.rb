# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  # Redirect to the home page after signing in
  def after_sign_in_path_for(_resource)
    root_path
  end
end
