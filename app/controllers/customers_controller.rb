class CustomersController < ApplicationController
  # Customer must be authenticated for edit, update, and destroy actions
  before_action :authenticate_customer!, only: %i[ edit update destroy ]

    # Set the @customer instance for actions like show, edit, update, destroy
  before_action :set_customer, only: %i[show edit update destroy ]
  
  # Logged-in customer can only modify their own profile
  before_action :correct_customer, only: %i[ edit update destroy ]
  
  #before_action :find_customer, only: [:show]

 # GET /customers or /customers.json
 def index
    @customers = Customer.all
    redirect_to root_path # Optionally redirect somewhere else, like the home page.
  end


  # GET /customers/1 or /customers/1.json
  def show
    @customer = Customer.find(params[:id])
  end


  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
    
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customer_url(@customer), notice: "Customer was successfully created." }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customer_url(@customer), notice: "Customer was successfully updated." }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy!

    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
    Rails.logger.info "Customers: #{@customers.inspect}"
  end

    # Only allow the logged-in customer to edit, update, or destroy their own profile
  def correct_customer
    unless current_customer == @customer
      redirect_to root_path, alert: "You are not authorized to modify this profile."
    end
  end

  # Only allow a list of trusted parameters through.
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :profile_picture,
    build_attributes: [:email, :active, :summary, :skills])
  end

  ''' def search_params_permitted
    #params.require(:search).permit(:major, :expected_graduation_date, :date_type)
    params.fetch(:search, {}).permit(:major, :expected_graduation_date, :date_type)
  end

  def filter_customers(search_params)
    Rails.logger.info "Controller Search Params in filter_customers: #{search_params.inspect}"
    customers = Customer.all

    if search_params[:major].present?
      customers = customers.where(major: search_params[:major])
      Rails.logger.info "Filtered by major: #{search_params[:major]}"
    end

    if search_params[:date_type].present? && search_params[:expected_graduation_date].present?
      #date = Date.parse(search_params[:expected_graduation_date])
      date = search_params[:expected_graduation_date]
      Rails.logger.info "Parsed date: #{date}"

      if search_params[:date_type] == "before"
        customers = customers.where("expected_graduation_date < ?", date)
        Rails.logger.info "Filtered by date before: #{date}"
      elsif search_params[:date_type] == "after"
        customers = customers.where("expected_graduation_date > ?", date)
        Rails.logger.info "Filtered by date after: #{date}"
      end
    end

    customers
  end '''



end
