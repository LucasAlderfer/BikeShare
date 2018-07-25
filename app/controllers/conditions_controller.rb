class ConditionsController < ApplicationController

  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def dashboard
    @trips = Trip.all
    @temps = [10..19,20..29,30..39,40..49,50..59,60..69,70..79,80..89,90..99]
  end
end
