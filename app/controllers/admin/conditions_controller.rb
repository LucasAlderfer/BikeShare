class Admin::ConditionsController < Admin::BaseController

  def new
    @condition = Condition.new
  end

  def create
    @condition = Condition.new(condition_params)
    if @condition.save
      flash[:success] = "You have successfully created #{@condition.cond_date} condition"
      redirect_to condition_path(@condition)
    else
      flash[:notice] = "Condition was not properly created"
      render :new
    end
  end

  def edit
    @condition = Condition.find(params[:id])
  end

  def update
    @condition = Condition.find(params[:id])
    @condition.update(condition_params)
    if @condition.save
      flash[:success] = "You have successfully updated condition for #{@condition.cond_date}"
      redirect_to condition_path(@condition)
    else
      flash[:notice] = "Condition was not properly updated"
      render :edit
    end
  end

  def destroy
    @condition = Condition.find(params[:id])
    @condition.destroy
    flash[:success] = "You have successfully deleted #{@condition.cond_date} condition"
    redirect_to conditions_path
  end


  private

  def condition_params
    params.require(:condition).permit(:cond_date, :max_temperature, :mean_temperature, :min_temperature, :mean_humidity, :mean_wind_speed, :mean_visibility, :precipitation)
  end
end
