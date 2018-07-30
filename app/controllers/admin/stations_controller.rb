class Admin::StationsController < Admin::BaseController

  def new
    @station = Station.new
  end

  def create
    params[:station][:installation_date] = Date.strptime(params[:station][:installation_date], '%m/%d/%Y')
    @station = Station.create(station_params)
    if @station.save
      flash[:success] = "You have successfully created #{@station.name} station"
      redirect_to station_path(@station.name)
    else
      flash[:notice] = "Station was not properly created"
      render :new
    end
  end

  def edit
    @station = Station.find_by(name: params[:slug])
  end

  def update
    #TODO conditional logic about date
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
    @station = Station.find_by(name: params[:slug])
    @station.destroy
    flash[:success] = "You have successfully deleted #{@station.name} station"
    redirect_to stations_path
  end

  private

  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end

end
