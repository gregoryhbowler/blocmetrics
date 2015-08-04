class API::EventsController < ApplicationController
  # Skip CSRF protection in development
  skip_before_action :verify_authenticity_token
  before_filter :set_access_control_headers

  def set_access_control_headers
# #1
    headers['Access-Control-Allow-Origin'] = '*'
# #2
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
# #3
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end

  def create
    registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])

    if registered_application == nil
      render json: "Unregistered application", status: :unprocessable_entity
      return
    end
    puts "here are the registered_application"
    puts "#{registered_application}"
    @event = registered_application.events.build(event_params)
    if @event.save
      render json: @event, status: :created
    else
      render @event.errors, status: :unprocessable_entity
    end
  end

  private
  def event_params
    params.require(:event).permit(:name)
  end
end
