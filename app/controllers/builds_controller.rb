class BuildsController < ApplicationController
  before_action :set_build, only: [:edit, :update, :destroy]
  
  def index
    @builds = current_customer.builds
  end

  def new
    @build = current_customer.builds.build
  end

  def create
    @build = current_customer.builds.build(build_params)
    if @build.save
      redirect_to builds_path, notice: "Build created successfully!"
    else
      render :new
    end
  end

  def update
    if @build.update(build_params)
      redirect_to builds_path, notice: "Build was successfully updated."
    else
      flash.now[:alert] = "Error updating build. Please check the form for errors."
      render :edit
    end
  end

  def edit
  end

  def destroy
    @build.destroy
    redirect_to builds_path, notice: "Build deleted successfully."
  end

  private

  def set_build
    @build = Build.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to builds_path, alert: "Build not found."
  end

  def build_params
    params.require(:build).permit(:title, :notes, :last_modified)
  end
end