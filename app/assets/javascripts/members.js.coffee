$(document).ready ->
  # 选择社区医生modal窗口内容设置与显示
  choose_doctor_num = undefined
  total_width = undefined
  hiden_width = undefined
  w_top = undefined
  $("#choose_doctor").click ->
    choose_doctor_num = $(".choose_doctor_num").text()
    total_width = 640 + 30 * (choose_doctor_num - 1)
    hiden_width = total_width/choose_doctor_num
    $(".accordian").css "width",total_width+"px"
    $(".accordian li").css "width",hiden_width+"px"
    $(window).scroll ->
      w_top = $(window).scrollTop()
      $("#choose_doctor_modal").css "top", w_top+"px"
    $("#choose_doctor_modal").modal show: true
  # 选择社区医生时滑动悬浮
  $(".accordian ul li").hover (->
    $(".accordian li").css "width",30+"px"
    $(this).css "width",640+"px"), ->
      $(".accordian li").css "width",hiden_width+"px"
