class NewInBody < ActiveRecord::Base
  belongs_to :member
  def get_fat_analysis_BMI
    array=["低标准","正常","过量","严重过量"]
    array[self.fat_analysis_BMI]
  end

  def get_fat_analysis_percent_body_fat
    array=["","正常","轻度肥胖","肥胖"]
    array[self.fat_analysis_percent_body_fat]
  end

  def get_fat_analysis_WHR
    array=["","正常","警惕","腹部肥胖"]
    array[self.fat_analysis_WHR]
  end

  def get_health_diagnosis_body_water
    array=["缺乏","正常"]
    array[self.health_diagnosis_body_water]
  end

  def get_health_diagnosis_edema
    array=["正常","轻度浮肿","浮肿"]
    array[self.health_diagnosis_edema]
  end

  def get_health_diagnosis_life_pattern
    array=["正常","警惕","风险","高风险"]
    array[self.health_diagnosis_life_pattern]
  end

  def get_nutritional_assessment_protein
    array=["缺乏","正常"]
    array[self.nutritional_assessment_protein]
  end

  def get_nutritional_assessment_salt
    array=["缺乏","正常"]
    array[self.nutritional_assessment_salt]
  end

  def get_nutritional_assessment_fat
    array=["缺乏","正常","过量"]
    array[self.nutritional_assessment_fat]
  end

  def get_nutritional_assessment_edema
    array=["正常","轻度浮肿","浮肿"]
    array[self.nutritional_assessment_edema]
  end

  def get_manage_weight
    array=["正常","低标准","过量"]
    array[self.manage_weight]
  end

  def get_manage_fat
    array=["低标准","正常","过量"]
    array[self.manage_fat]
  end

  def get_manage_skeletal_muscle
    array=["低标准","正常","高标准"]
    array[self.manage_skeletal_muscle]
  end


  def get_balanced_analysis_arm
    array=["均衡","轻度不均","严重不均"]
    array[self.balanced_analysis_arm]
  end
  def get_balanced_analysis_leg
    array=["均衡","轻度不均","严重不均"]
    array[self.balanced_analysis_leg]
  end
  def get_balanced_analysis_arm_leg
    array=["均衡","轻度不均","严重不均"]
    array[self.balanced_analysis_arm_leg]
  end
  def get_physical_strength_arm
    array=["不足","正常","发达"]
    array[self.physical_strength_arm]
  end
  def get_physical_strength_leg
    array=["不足","正常","发达"]
    array[self.physical_strength_Leg]
  end
  def get_physical_strength_muscle
    array=["不足","正常","发达"]
    array[self.physical_strength_muscle]
  end
end
