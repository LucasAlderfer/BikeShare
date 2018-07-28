class Admin::TripsController < Admin::BaseController

  def new
    @trip = Trip.new
    @stations = Station.all
  end

  def create
    # params[:trip][:start_station_id] = params[:trip][:start_station_id].to_i
    # params[:trip][:end_station_id] = params[:trip][:end_station_id].to_i
    # binding.pry
    @trip = Trip.create!(trip_params)
    if @trip.save
      flash[:success] = "You have successfully created a trip starting on#{@trip.start_date}"
      redirect_to trip_path(@trip)
    else
      flash[:notice] = 'Trip was not properly created'
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:duration, :bike_id, :start_date, :end_date, :zip_code, :subscription_type, :start_station_id, :end_station_id)
  end
end
