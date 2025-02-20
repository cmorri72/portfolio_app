class ApplicationController < ActionController::Base
   #configure_permitted_parameters: method runs before each Devise controller action.
   before_action :configure_permitted_parameters, if: :devise_controller?

    #override after_sign_in_path_for method that is called by Devise
    def after_sign_in_path_for(resource)
        root_path # Redirect to the home page or any other route.
    end

        #override after_sign_in_path_for method that is called by Devise
    def after_sign_up_path_for(resource)
        root_path # Redirect to the home page or any other route.
    end

   #protected methods in class
   protected

   #override configure_permitted_parameters method to allow additional parameters
   #by default devise only allows email, password and password_confirmation
   def configure_permitted_parameters
       # parameters allowed during sign up
       devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :profile_picture])
       # parameters that can be updated
       devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :profile_picture])
   end

end

