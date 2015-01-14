$(document).ready ->
  $("#create_phy_exam_record").click ()->
    $("#new_phy_exam_record_modal").modal show:true

  #input enter keydown event handle
  if $(".phy_exam_main_content").length > 0
    $inp = $('.phy_exam_input')
    $("input").keydown (event) ->
      if (event.which==13)
        event.preventDefault()
        nextIndex=$inp.index(this)+1
        $(".phy_exam_input:eq("+ nextIndex + ")").focus()
    $(".phy_exam_input:first").focus()

    # nav current position
    phe_nav_pos = $(".phy_exam_nav").offset();
    # nav init
    phe_nav_step = 20
    phe_nav_y= phe_nav_pos.top
    phe_main_top = $(".phy_exam_page_nav").offset().top+$(".phy_exam_page_nav").height()
    phe_main_bottom = $(".phy_exam_main_content").offset().top+ $(".phy_exam_main_content").height()-$(".phy_exam_nav").height()-3* phe_nav_step
    #phe_nav_step = $(".phy_exam_nav").height()
   
    # scroll event handle
    $(window).scroll (event) ->
      $(".phy_exam_nav").css("position","absolute")
      $(".phy_exam_nav").css("left",phe_nav_pos.left + "px")
      phe_nav_y = $(this).scrollTop() + phe_nav_step
      #phe_nav_y = $(this).scrollTop()
      # top boder
      if (phe_nav_y <= phe_main_top || $(this).scrollTop()==0)
        phe_nav_y = phe_main_top

      if (phe_nav_y >= phe_main_bottom)
        phe_nav_y = phe_main_bottom

      # set nav position
      $(".phy_exam_nav").css("top", phe_nav_y-2* phe_nav_step + "px")
      $(".phy_exam_nav").css("left",phe_nav_pos.left + "px")
     
    $(".phy_exam_nav li:first-child").addClass("phy_exam_nav_active")
    $(".phy_exam_nav li").click () ->
      $(this).siblings().removeClass("phy_exam_nav_active")
      $(this).addClass("phy_exam_nav_active")