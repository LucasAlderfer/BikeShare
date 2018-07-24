class TripsController < ApplicationController

  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def dashboard
    #TODO move methods out of view
    @trips = Trip.all
  end

end
