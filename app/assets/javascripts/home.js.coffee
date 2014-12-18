$(document).ready ->
  # 初始化隐藏二级菜单
  $(".second_nav").hide()
  $(".title").each ->
    $(this).siblings("ul").css "top",$(this).offset().top+"px"
  # 一级菜单点击悬浮显示二级菜单
  $(".left_nav_first_li").hover ->
    $(".title",this).css
      "background":"linear-gradient(90deg, rgb(203, 245, 219), white)"
      "color":"rgb(40, 127, 68)"
    $(".second_nav",this).fadeIn 300
  $(".left_nav_first_li").mouseleave ->
    $(".title",this).css
      "background":"linear-gradient(90deg, rgb(40, 127, 68), rgb(40, 127, 68))"
      "color":"white"
    $(".second_nav",this).fadeOut 300


  # 设置每个模块的高度自适应浏览器高度
  h = $(window).height()
  $(".bac_box").css "height", h + "px"
  # 获取页面一共有多少个模块
  bac_box_num = $(".bac_box").size()
  # 对滚动条监听
  $(window).scroll ->
    w_top = $(window).scrollTop()
    # if w_top == 0 then $("#top_nav").css("display","block") else $("#top_nav").css("display","none")
    i = 0
    while i <= bac_box_num - 1
      if i * h <= w_top and w_top < (i + 1) * h
        $(".indicator").removeClass "current"
        $(".indicator").eq(i).addClass "current"
      i++
