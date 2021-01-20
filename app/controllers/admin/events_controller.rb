module Admin
  class EventsController < BaseController

    def index
      @events = Event.all
    end

    def show
      @event = Event.find(params[:id])
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)
      if @event.save
        flash[:success] = 'Event created successfully'
      else
        flash[:alert] = 'Event cannot be created'
      end
      redirect_to admin_events_path
    end

    def edit
      @event = Event.find(params[:id])
    end

    def update
      @event = Event.find(params[:id])
      @event.update(event_params)
      redirect_to admin_events_path
    end

    private
    def event_params
      params.require(:event).permit(:name, :description, :start_date, :end_date, :image, :location)
    end
  end
end
