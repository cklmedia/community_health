class PhyExamRecordsController < ApplicationController
  def index
  	@phy_exam_records = PhyExamRecord.all.paginate(:page => params[:page])
  end

  def create
  	@phy_exam_record = PhyExamRecord.new(phy_exam_tpl_id:params[:phy_exam_record][:phy_exam_tpl_id],doctor_id:current_user.id,member_id:params[:member_id])
  	if @phy_exam_record.save
  	  create_record(@phy_exam_record.phy_exam_tpl_id,@phy_exam_record.id)
  	  flash[:success] = "添加体检档案成功，现在开始填写体检项目吧！"
      redirect_to :action => :edit, :id => @phy_exam_record
  	else
  	  flash[:danger] = "添加体检模版失败，再来一次！"
      redirect_to :back 
  	end
  end

  def create_record(phy_exam_tpl_id,exam_record_id)
    PhyExamTplItem.where(phy_exam_tpl_id: phy_exam_tpl_id).each do |i|
      @category_item = CategoryItem.find(i.category_item_id)
      @record_item = PhyExamRecordItem.new(
        phy_exam_record_id: exam_record_id,
        phy_exam_tpl_item_id: i.id,
        category_id: @category_item.category_id)
      @record_item.save
    end
    Category.all.each do |c|
      if !(c.get_items(phy_exam_tpl_id).empty?)
        @record_extra = PhyExamRecordExtra.new(
          phy_exam_record_id: exam_record_id,
          category_id: c.id)
        @record_extra.save
      end
    end
  end

  def show
  	@phy_exam_record = PhyExamRecord.find(params[:id])
  end

  def update_record
    phy_exam_record=PhyExamRecord.find(params[:id])
    phy_exam_record.update_attributes(phy_records_file: params[:phy_records_file],phy_tpl_conclusion:params[:phy_tpl_conclusion],phy_tpl_advise:params[:phy_tpl_advise])
    i=0
    params[:phy_exam_tpl_item_ids].each do |w|
      record_item=PhyExamRecordItem.where(:phy_exam_record_id => phy_exam_record.id,:phy_exam_tpl_item_id => w)[0]
      if record_item.update_attributes(:result => params[:results][i],:decide => params[:decides][i])
        i+=1
      else
        flash[:danger] = "录入失败，再来一次！"
        redirect_to :back
      end
    end
    i=0
    params[:category_ids].each do |w|
      record_extra=PhyExamRecordExtra.where(:category_id => w,:phy_exam_record_id => phy_exam_record.id)[0]
      if record_extra.update_attributes(:content => params[:contents][i],:doctor => params[:doctors][i])
        i+=1
      else
        flash[:danger] = "录入失败，再来一次！"
        redirect_to :back
      end
    end
    flash[:success] = "录入成功!"
    redirect_to phy_exam_records_path
  end

  def edit
  	@phy_exam_record = PhyExamRecord.find(params[:id])
  end
end
