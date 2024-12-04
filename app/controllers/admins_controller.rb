class AdminsController < ApplicationController
  before_action :authenticate_admin! # Ensure only admins can access the dashboard
  
  def dashboard
    @customers = Customer.all
    @builds = Build.all # Adjust as necessary for your app
  end
end  