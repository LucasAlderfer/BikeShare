class StationsController < ApplicationController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.find_by_name(params[:slug])
  end

  def dashboard
    @stations_total = Station.stations_count
    @average_docks = Station.avg_docks
    @most_docks     = Station.max_bikes
    @least_docks   = Station.min_bikes
    @youngest_stat  = Station.youngest
    @oldest_stat    = Station.oldest
  end

end
