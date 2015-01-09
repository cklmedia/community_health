$(document).ready ->
  # 选择社区医生modal窗口内容设置与显示
  choose_doctor_num = undefined
  total_width = undefined
  hiden_width = undefined
  w_top = undefined
  $("#choose_doctor").click ->
    choose_doctor_num = $(".choose_doctor_num").text()
    total_width = 640 + 40 * (choose_doctor_num - 1)
    hiden_width = total_width/choose_doctor_num
    $(".accordian").css "width",total_width+"px"
    $(".accordian li").css "width",hiden_width+"px"
    $(window).scroll ->
      w_top = $(window).scrollTop()
      $("#choose_doctor_modal").css "top", w_top+"px"
    $("#choose_doctor_modal").modal show: true
  # 选择社区医生时滑动悬浮
  $(".accordian ul li").hover (->
    $(".accordian li").css "width",40+"px"
    $(this).css "width",640+"px"), ->
      $(".accordian li").css "width",hiden_width+"px"
  # 绑定社区医生
  $(".bundling_doctor").click ->
    doctor_id = $(this).attr("data-doctor-id")
    $.get "/members/bundling_doctor/" + doctor_id, (data) ->
      if data.result2
        alert "结交成功，赶紧去和你的新社区医生交流吧！"
      else
        alert "结交失败，请刷新之后再来一次！"
      window.location.reload()

  # 使聊天窗口滚动条出现在最后端
  $("#communicate_doc_content")[0].scrollTop = $("#communicate_doc_content")[0].scrollHeight if $("#communicate_doc_content")[0]
  # 获取与社区医生的信息条数
  if $("#m_get_msg_time").text()
    if $("#member_show_id").text() then member_id = $("#member_show_id").text() else member_id = "null"
    get_new_msg_num = ->
      time = $("#m_get_msg_time").text()
      $.get "/members/get_new_msg_num/" + time + "&" + member_id, (data) ->
        $(".new_m_msg_show").text data.number+"条新信息"
    setInterval get_new_msg_num, 3000
