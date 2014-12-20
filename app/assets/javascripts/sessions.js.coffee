$(document).ready ->
  $(".session_form .switch-left").text "社区医生"
  $(".session_form .switch-right").text "居民"

  $(".user_sex .switch-left").text "男"
  $(".user_sex .switch-right").text "女"

  $(".create_user_link").click ->
    $("#create_user_modal").modal show: true
  $(".reload_window").click ->
  	window.location.reload()