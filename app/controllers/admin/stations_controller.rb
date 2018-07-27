class Admin::StationsController < Admin::BaseController

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      flash[:success] = "You have successfully created #{@station.name} station"
      redirect_to station_path(@station.name)
    else
      flash[:notice] = "Station was not properly created"
      render :new
    end
  end

  def edit
    @station = Station.find_by_slug(params[:slug])
  end

  def update
    @station = Station.find(params[:slug])
    @station.update(station_params)
    if @station.save
      flash[:success] = "You have successfully updated #{@station.name} station"
      redirect_to station_path(@station.name)
    else
      flash[:notice] = "Station was not properly updated"
      render :edit
    end
  end

  def destroy
    @station = Station.find_by_slug(params[:slug])
    @station.destroy
    flash[:success] = "You have successfully deleted #{@station.name} station"
    redirect_to stations_path
  end

  private

  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end

end
