module ApplicationHelper
  def get_user_edit_url(class_name)
    url = edit_member_path(current_user) if class_name == "Member"
    url = edit_doctor_path(current_user) if class_name == "Doctor"
    url
  end
  def get_logo_url(class_name)
  	url = members_path if class_name == "Member"
    url = root_path if class_name == "Doctor"
    url
  end
end
