class DoctorsController < ApplicationController
  def create
  	doctor = Doctor.new(doctor_params)
  	if doctor.save
  	  sign_in doctor
  	  flash[:success] = "恭喜您注册成功！"
      redirect_to root_path
  	else
      flash[:danger] = "注册失败，再来一次。"
      redirect_to :back
  	end
  end

  def edit
    @doctor = Doctor.find(params[:id])
  end

  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update_attributes(doctor_params)
      flash[:success] = "恭喜您完善资料成功！"
      redirect_to root_path
    else
      flash[:danger] = "修改失败，再来一次。"
      redirect_to :back
    end
  end

  private
    def doctor_params
      permited=params.require(:doctor).permit(:name,:tel,:password,:password_confirmation,:avatar,:introduce)
      if params[:sex] then permited[:sex]= "男" else  permited[:sex]= "女" end
      permited
    end
end
