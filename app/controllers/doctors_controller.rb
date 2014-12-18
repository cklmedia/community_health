class DoctorsController < ApplicationController
  def create
  	doctor = Doctor.new(doctor_params)
  	if params[:doctor][:sex] then doctor.sex = "男" else  doctor.sex = "女" end
  	if doctor.save
  	  sign_in doctor
  	  flash[:success] = "恭喜您注册成功！"
      redirect_to root_path
  	else
      flash[:danger] = "注册失败，再来一次。"
      redirect_to :back
  	end
  end

  private
    def doctor_params
      permited=params.require(:doctor).permit(:name,:tel,:password,:password_confirmation,:avatar,:introduce) 
    end
end
