$(document).ready ->
  $(".phy_exam_category_content").hide()

  $(".phy_exam_category_content").eq(0).show()
  $("#phy_exam_category_info h3").eq(0).css "color","red"
  $("#phy_exam_category_info h3").click () ->
    $(".phy_exam_category_content").hide()
    $(".phy_exam_category_content").eq($(this).parent().index()).show()
    $(this).css "color","red"
    $(this).parent().siblings().children().css "color","#2696d8"

  $("#create_phy_exam_tpl").click ()->
    $("#new_phy_exam_modal").modal show:true

# change the div'visibility because of the value of the result_type select
$(document).ready ->
  $("#result_type_id").change () ->
    result_type_selected = $("#result_type_id").find("option:selected")
    if (result_type_selected.text()=="数值")
      $("#num_type").show()
    else
      $("#num_type").hide()