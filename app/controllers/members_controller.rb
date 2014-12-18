class MembersController < ApplicationController
  def create
  	member = Member.new(member_params)
  	if params[:member][:sex] then member.sex = "男" else  member.sex = "女" end
  	if member.save
  	  sign_in member
  	  flash[:success] = "恭喜您注册成功！"
      redirect_to root_path
  	else
      flash[:danger] = "注册失败，再来一次。"
      redirect_to :back
  	end
  end

  private
    def member_params
      permited=params.require(:member).permit(:name,:birthday,:health,:password,:password_confirmation,:avatar,:sex,:building,:unit,:house,:tel) 
    end
end
