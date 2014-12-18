class SessionsController < ApplicationController
  def new
 	render layout: false
  end
  def create
  	if params[:admin]
  	  user = Doctor.find_by_tel(params[:session][:tel])
  	else
  	  user = Member.find_by_tel(params[:session][:tel])
  	end
  	if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "欢迎你！#{user.name}"
      redirect_to root_path if user.class.to_s == "Doctor"
      redirect_to members_path if user.class.to_s == "Member"
    else
      flash[:danger] = "联系方式或密码不一致，请确认重新登录！"
      redirect_to new_session_path
    end
  end
  def destroy
  	session[:user_id]=nil
    redirect_to new_session_path
  end
end
