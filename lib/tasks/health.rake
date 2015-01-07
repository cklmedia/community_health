namespace :health do
  def create_ihealth_category
    puts "************create health phyexam data**************\n"
    ihealth_category = ActiveSupport::JSON.decode(File.read('db/seeds/category.json'))
    categories = ihealth_category["categories"]
    Category.delete_all
    categories.each do |category|
      category_tmp = Category.create(name: category["name"])
      next unless category["items"]
      category["items"].each do |item|
        if !item["contents"]
          category_tmp.category_items.create(name: item["name"])
        else
          item["contents"].each do |content|
            category_tmp.category_items.create(name: content["name"],item_tag:item["name"])
          end
        end
      end
    end
  end

  def seed_tpl_data
    puts "************create health phyexam template start**************\n"
    all_tpl = PhyExamTpl.create(name:"全项目体检模版")
    all_category = Category.all
    all_category.each do |category|
      category.category_items.each do |item|
        rs = PhyExamStandResult.create(result_type_id: 1,result_text: "正常")
        all_tpl.phy_exam_tpl_items.create(category_item:item,phy_exam_stand_result:rs)
      end
    end
  end

  task :load_categories => :environment do
    create_ihealth_category
  end

  task :seed_tpl_data => :environment do
    seed_tpl_data
  end
  task :all =>[:load_categories,:seed_tpl_data]

end