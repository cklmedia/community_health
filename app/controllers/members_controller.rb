class MembersController < ApplicationController
  def create
  	member = Member.new(member_params)
  	if member.save
  	  sign_in member
  	  flash[:success] = "恭喜您注册成功！"
      redirect_to members_path
  	else
      flash[:danger] = "注册失败，再来一次。"
      redirect_to :back
  	end
  end

  def index
    @member = Member.find(current_user.id)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(member_params)
      flash[:success] = "恭喜您完善资料成功！"
      redirect_to members_path
    else
      flash[:danger] = "修改失败，再来一次。"
      redirect_to :back
    end
  end

  private
    def member_params
      permited=params.require(:member).permit(:name,:birthday,:health,:password,:password_confirmation,:avatar,:sex,:building,:unit,:house,:tel)
      if params[:member][:sex] then permited[:sex]= "男" else  permited[:sex]= "女" end
      permited
    end
end
