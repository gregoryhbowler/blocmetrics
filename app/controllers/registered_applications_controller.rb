class RegisteredApplicationsController < ApplicationController

  def index
    @registered_applications = current_user.registered_applications.all
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events.group_by(&:name)
  end

  def edit
    @registered_application = RegisteredApplication.find(params[:id])
  end

  def create
    @registered_application = current_user.registered_applications.build(reg_app_params)

    if @registered_application.save
      redirect_to registered_applications_path
    else
      flash[:error] = "Error registering the application. Please try again."
      render :new
    end
  end

  def update
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.update_attributes(reg_app_params)
      redirect_to registered_applications_path
    else
      flash[:error] = "Error updating the application. Please try again."
      render :edit
    end
  end

  def destroy
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.destroy
      flash[:notice] = "\"#{@registered_application.name}\" was deleted successfully."
      redirect_to registered_applications_path
    else
      flash[:error] = "There was an error deleting the application."
      render :show
    end
  end




  private

  def reg_app_params
    params.require(:registered_application).permit(:name, :url)
  end
end
