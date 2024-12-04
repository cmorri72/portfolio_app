class HomeController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @items = Item.all
    if current_admin
      @message = "Welcome to JET PWR, Admin!"
      @button_text = "Go to Dashboard"
      @button_path = admin_dashboard_path
    elsif current_customer
      @message = "Welcome to JET PWR, #{current_customer.first_name}!"
      @button_text = "My Builds"
      @button_path = builds_path
    else
      @message = "Welcome to JET PWR!"
      @button_text = "Sign In"
      @button_path = new_customer_session_path
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: 'Item successfully added to inventory!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path, notice: 'Item successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path, notice: 'Item successfully removed from inventory!'
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image)
  end
end