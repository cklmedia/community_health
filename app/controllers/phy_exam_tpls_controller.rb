class PhyExamTplsController < ApplicationController
  def index
  	@phy_exam_tpls = PhyExamTpl.all.paginate(:page => params[:page])
  end

  def edit
  	@phy_exam_tpl = PhyExamTpl.find(params[:id])
  end

  def update
  	@phy_exam_tpl = PhyExamTpl.find(params[:id])
	  if @phy_exam_tpl.update_attributes(name:params[:phy_exam_tpl][:name],agency:params[:phy_exam_tpl][:agency])
	    flash[:success] = "体检模版修改成功！"
	    redirect_to :back 
	  else
	    flash[:danger] = "体检模版修改失败！"
	    redirect_to :back
	  end
  end

  def destroy
  	@phy_exam_tpl = PhyExamTpl.find(params[:id])
  	if @phy_exam_tpl.destroy
      flash[:success] = "删除体检模版成功！"
      redirect_to phy_exam_tpls_path
    else
      flash[:danger] = "删除体检模版失败！"
	  redirect_to :back
    end
  end

  def destroy_item
  	phy_exam_tpl_items = PhyExamTplItem.find(params[:id])
  	if phy_exam_tpl_items.destroy
  	  flash[:success] = "删除体检模版项目成功！"
      redirect_to :back
    else
      flash[:danger] = "删除体检模版项目失败！"
	  redirect_to :back
    end
  end

  def destroy_multiple
  	if params[:item_ids].blank?
      flash[:danger] = "请选择删除项目！"
      redirect_to :back
    else  
      phy_exam_tpl_items = PhyExamTplItem.find(params[:item_ids])
      phy_exam_tpl_items.each do |w|
        w.destroy
      end  
      flash[:success] = "删除项目成功！"
      redirect_to :back
    end
  end

  def create
  	@phy_exam_tpl = PhyExamTpl.new(name:params[:phy_exam_tpl][:name],agency:params[:phy_exam_tpl][:agency])
  	if @phy_exam_tpl.save
      create_item_multiple(params[:father_tpl_id],@phy_exam_tpl.id)
      flash[:success] = "添加体检模版成功，现在开始管理体检项目吧！"
      redirect_to :action => :edit, :id => @phy_exam_tpl
    else
      flash[:danger] = "添加体检模版失败，再来一次！"
      redirect_to :back 
    end
  end

  def save_items
    @phy_exam_tpl_id=params[:phy_exam_tpl_id]
    @phy_exam_tpl_item = PhyExamTplItem.new(phy_exam_tpl_id: @phy_exam_tpl_id,
      category_item_id: params[:category_item_id])
    @category_item=CategoryItem.find(params[:category_item_id])
    @category_id=@category_item.category_id
    respond_to do |format|
      if @phy_exam_tpl_item.save
        @phy_exam_stand_result = PhyExamStandResult.new(phy_stand_result_params)
        @phy_exam_stand_result.phy_exam_tpl_item_id = @phy_exam_tpl_item.id
        if @phy_exam_stand_result.save 
          flash[:success]="项目添加成功！"
          format.html { redirect_to 'edit' }
          format.js {render "update_item"}
        else
          flash[:danger] = "项目添加失败！"
          format.html { redirect_to 'edit' }
          format.js {render "update_item"}
        end
      else
        flash[:danger] = "项目添加成功！"
        format.html { redirect_to 'edit' }
        format.js {render "update_item"}
      end
    end
  end

  def update_item
    @phy_exam_stand_result = PhyExamStandResult.find(params[:id])
    @phy_exam_tpl_item = PhyExamTplItem.find(params[:id])
    @phy_exam_tpl_id=@phy_exam_tpl_item.phy_exam_tpl_id
    @category_item=CategoryItem.find(@phy_exam_tpl_item.category_item_id)
    @category_id=@category_item.category_id
    respond_to do |format|
      if  @phy_exam_stand_result.update_attributes(phy_stand_result_params) && @phy_exam_tpl_item.update_attributes(category_item_id: params[:category_item_id])
        format.html { redirect_to 'edit' }
        format.js
      else
        format.html { render 'edit' }
        format.js
      end
    end
  end

  def list_stand_result
    stand_result = PhyExamStandResult.find(params[:id])
    render :json => stand_result.to_json
  end

  def list_catagory_item
    category_items = CategoryItem.group_category(params[:id]).collect {|p| [ p.name, p.id ]}
    render :json => category_items.to_json
  end

  def create_item_multiple(father_tpl_id,child_tpl_id)
    if father_tpl_id!=nil
      PhyExamTplItem.transaction do
        PhyExamStandResult.transaction do
          PhyExamTplItem.where(:phy_exam_tpl_id => father_tpl_id).each do |i|
            @child_tpl_item=PhyExamTplItem.new(
              :phy_exam_tpl_id => child_tpl_id,
              :category_item_id => i.category_item_id)
            @child_tpl_item.save
            @father_stand=PhyExamStandResult.find(i.id)
            @child_stand=PhyExamStandResult.new(
              :name => @father_stand.name,
              :phy_exam_tpl_item_id => @child_tpl_item.id,
              :definition_type => @father_stand.definition_type,
              :unit => @father_stand.unit,
              :device => @father_stand.device,
              :result_type_id => @father_stand.result_type_id,
              :normal_max => @father_stand.normal_max,
              :normal_min => @father_stand.normal_min,
              :description => @father_stand.description,
              :result_text => @father_stand.result_text)
            @child_stand.save
          end
        end
      end
    end
  end

  private
    def phy_stand_result_params
      permited=params.permit(:definition_type,:unit,
        :device,:result_type_id,
        :normal_max,:normal_min,
        :result_text,:description)
    end
end
