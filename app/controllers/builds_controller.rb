class BuildsController < ApplicationController
  before_action :authenticate_customer!, unless: -> { current_admin.present? }
  before_action :authenticate_admin!, if: -> { current_admin.present? }
  before_action :set_build, only: [:edit, :update, :destroy] # Add only valid actions here

  def index
    if current_customer
      @builds = current_customer.builds
    elsif current_admin && params[:customer_id]
      @customer = Customer.find(params[:customer_id])
      @builds = @customer.builds
    else
      @builds = []
    end
  end

  def new
    if current_customer
      @build = current_customer.builds.new
    elsif current_admin && params[:customer_id]
      @customer = Customer.find(params[:customer_id])
      @build = @customer.builds.new
    else
      redirect_to root_path, alert: 'Unauthorized access.'
    end
  end
  

  def create
    if current_customer
      @build = current_customer.builds.new(build_params)
    elsif current_admin && params[:customer_id]
      @customer = Customer.find(params[:customer_id])
      @build = @customer.builds.new(build_params)
    else
      redirect_to root_path, alert: 'Unauthorized access.'
      return
    end
  
    if @build.save
      redirect_to (current_admin ? customer_admins_builds_path(customer_id: @build.customer_id) : builds_path), notice: 'Build successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  def edit
    # The @build instance is already set by the `set_build` callback
  end

  def update
    if @build.update(build_params)
      redirect_to (current_admin ? customer_admins_builds_path(customer_id: @build.customer_id) : builds_path), notice: 'Build successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_admin || @build.customer == current_customer
      @build.destroy
      redirect_to (current_admin ? customer_admins_builds_path(customer_id: @build.customer_id) : builds_path), notice: 'Build successfully deleted!'
    else
      redirect_to root_path, alert: 'You are not authorized to delete this build.'
    end
  end

  private

  def set_build
    @build = if current_admin
               Build.find(params[:id]) # Admins can access any build
             else
               current_customer.builds.find(params[:id]) # Customers can only access their own builds
             end
  end

  def build_params
    params.require(:build).permit(:title, :notes, :last_modified)
  end
end



