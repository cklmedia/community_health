module MembersHelper
  def can_bundling_doctor?(doctor_id)
  	"display_itme" if current_user.doctor_id == doctor_id
  end
end
