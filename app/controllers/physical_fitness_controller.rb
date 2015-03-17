class PhysicalFitnessController < ApplicationController
  def index
    @active_tab = params[:active_tab]
    default_page = 1
  	@health_bmds=HealthBmd.paginate(:page => (@active_tab == "health_bmds" ? params[:page] : default_page  ))
  	@arteriosclerosis=Arteriosclerosis.paginate(:page => (@active_tab == "health_arterioscleroses" ? params[:page] : default_page ))
  	@health_aerobics=HealthAerobic.paginate(:page => (@active_tab == "health_aerobics" ? params[:page] : default_page ))
  	@national_physicals=NationalPhysical.paginate(:page => (@active_tab == "national_physicals" ? params[:page] : default_page ))
  	@diabetes=Diabetes.paginate(:page => (@active_tab == "diabetes" ? params[:page] : default_page ))
  	@new_in_bodies=NewInBody.paginate(:page => (@active_tab == "new_in_bodies" ? params[:page] : default_page ))
    @balances = Balance.paginate(:page => (@active_tab == "balances" ? params[:page] : default_page ))
  end
  def show_bmd
    @health_bmd=HealthBmd.find(params[:id])
  end

  def show_balance
    @balance=Balance.find(params[:id])
  end

  def show_arteriosclerosis
    @arteriosclerosis=Arteriosclerosis.find(params[:id])
  end

  def show_health_aerobic
    @health_aerobics=HealthAerobic.find(params[:id])
  end

  def show_national_physical
    @national_physical=NationalPhysical.find(params[:id])
  end

  def show_diabete
    @diabete=Diabetes.find(params[:id])
  end

  def show_new_in_bodies
    @new_in_body=NewInBody.find(params[:id])
  end
end
