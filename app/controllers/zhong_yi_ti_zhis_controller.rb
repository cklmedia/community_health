class ZhongYiTiZhisController < ApplicationController
  def index
  	@zhong_yi_ti_zhis = ZhongYiTiZhi.all.paginate(:page => params[:page])
  end
end
