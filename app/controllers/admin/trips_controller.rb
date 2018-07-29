class Admin::TripsController < Admin::BaseController

  def new
    @trip = Trip.new
    @stations = Station.all
  end

  def create
    @trip = Trip.create!(trip_params)
    if @trip.save
      flash[:success] = "You have successfully created a trip starting on#{@trip.start_date}"
      redirect_to trip_path(@trip)
    else
      flash[:notice] = 'Trip was not properly created'
      render :new
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update!(trip_params)
    if @trip.save
      # binding.pry
      flash[:success] = "You have successfully updated at trip starting on #{@trip.start_date}"
      redirect_to trip_path(@trip)
    else
      flash[:notice] = "Trip was not properly updated"
      render :edit
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    flash[:success] = "You have successfully deleted Trip starting on #{trip.start_date} station"
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:duration, :bike_id, :start_date, :end_date, :zip_code, :subscription_type, :start_station_id, :end_station_id)
  end
end
