class Admins::BuildsController < ApplicationController
    before_action :authenticate_admin!
  
    def index
      @customer = Customer.find(params[:customer_id])
      @builds = @customer.builds
    end
  
    def new
      @customer = Customer.find(params[:customer_id])
      @build = @customer.builds.new
    end
  
    def create
      @customer = Customer.find(params[:customer_id])
      @build = @customer.builds.new(build_params)
  
      if @build.save
        redirect_to customer_admins_builds_path(customer_id: @customer.id), notice: 'Build successfully created!'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
    def build_params
      params.require(:build).permit(:title, :notes, :last_modified)
    end
end
  
  