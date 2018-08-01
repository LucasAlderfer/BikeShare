class ConditionsController < ApplicationController

  def index
    @conditions = Condition.all.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def dashboard
    @trips = Trip.all
    @temps = [30..39,40..49,50..59,60..69,70..79,80..89,90..99]
    @precipitations = [0..0.49, 0.5..0.99, 1.0..1.49, 1.50..1.99, 2.0..2.49, 2.5..2.99]
    @wind_speeds = [0..3.9, 4..7.9, 8..11.9, 12..15.9]
    @visibilities = [0..3.9, 4..7.9, 8..11.9]
  end
end
