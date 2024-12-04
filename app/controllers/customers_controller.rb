class CustomersController < ApplicationController
  # Authenticate customer for certain actions
  before_action :authenticate_customer!, only: %i[edit update destroy]
  before_action :set_customer, only: %i[show edit update destroy]
  before_action :correct_customer, only: %i[edit update destroy]

  # GET /customers
  def index
    @customers = Customer.all
    redirect_to root_path
  end

  # GET /customers/:id
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/:id/edit
  def edit
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customer_url(@customer), notice: 'Customer was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/:id
  def update
    if @customer.update(customer_params)
      redirect_to customer_url(@customer), notice: 'Customer was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /customers/:id
  def destroy
    @customer.destroy
    redirect_to customers_url, notice: 'Customer was successfully destroyed.'
  end

  private

  # Set the current customer for specific actions
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Ensure the logged-in customer can only modify their own profile
  def correct_customer
    unless current_customer == @customer
      redirect_to root_path, alert: 'You are not authorized to modify this profile.'
    end
  end

  # Strong parameters for customer
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :profile_picture, build_attributes: %i[email active summary skills])
  end
end

