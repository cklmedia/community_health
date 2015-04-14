module CommunityHealthApi
  ### API Helper
  module APIHelpers

    def logger
      API.logger
    end

    def validate_auth_key(auth_key)
      return true if AuthKey.where(:key => auth_key).first
      false
    end

  end

  module APIEntities

    class UserInfo < Grape::Entity
      expose :name
      expose :sex
      expose :card
      expose :register_pwd
      expose :user_avatar_url
      expose :register_status do |records, options|
        if !records.register_records.blank?
          RegisterRecord.get_last_register(records.id,"status")
        else
          -1
        end
      end
      expose :last_time do |records, options|
        if !records.register_records.blank?
          RegisterRecord.get_last_register(records.id,"time")
        else
          "-1"
        end
      end
    end

    class User <  Grape::Entity
      expose :success_status, as: :status
      private
        def success_status
          1
        end
      expose :records, using: APIEntities::UserInfo do |records, options|
        r = options[:records]
        r
      end
    end

  end

  class API < Grape::API

    prefix "api"
    format :json

    helpers APIHelpers

    # 血压
    post "/post_blood_pressure" do
      res = BloodPressure.new(member_id:params[:member_id],
        diastolic:params[:diastolic],
        systolic:params[:systolic],
        pulse:params[:pulse])
      if res.save
        return {"status" => 1,"msg" => "succeed"}
      else
        return {"status" => 0,"msg" => "fail"}
      end
    end
    # 血糖
    post "/post_blood_sugar" do
      res = BloodSugar.new(member_id:params[:member_id],
        result:params[:result],
        test_type:params[:test_type],
        measure_time:params[:measure_time])
      if res.save
        return {"status" => 1,"msg" => "succeed"}
      else
        return {"status" => 0,"msg" => "fail"}
      end
    end
    # 体温
    post "/post_body_temperatures" do
      res = BodyTemperature.new(member_id:params[:member_id],
        result:params[:result],
        measure_time:params[:measure_time])
      if res.save
        return {"status" => 1,"msg" => "succeed"}
      else
        return {"status" => 0,"msg" => "fail"}
      end
    end
    # 尿酸
    post "/post_purine_triones" do
      res = PurineTrione.new(member_id:params[:member_id],
        result:params[:result],
        test_type:params[:test_type],
        measure_time:params[:measure_time])
      if res.save
        return {"status" => 1,"msg" => "succeed"}
      else
        return {"status" => 0,"msg" => "fail"}
      end
    end
    # 中医体质辨识
    post "/post_zhong_yi_ti_zhis" do
      res = PurineTrione.new(member_id:params[:member_id],
        result:params[:result])
      if res.save
        return {"status" => 1,"msg" => "succeed"}
      else
        return {"status" => 0,"msg" => "fail"}
      end
    end

  end

end