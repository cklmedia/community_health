window.App =
  #edit modal for tpl_item_function
  phy_exam_tpl_item_edit : (category_id,tpl_item_id,category_item_id) ->
    padding = (tpl_item_id) ->
      $.get "/phy_exam_tpls/list_stand_result/" + tpl_item_id, (data) ->
        $("#result_type_id").val data.result_type_id
        if (data.result_type_id == 2)
          $("#num_type").show()
        else
          $("#num_type").hide()
        $("#unit").val data.unit
        $("#normal_max").val data.normal_max
        $("#normal_min").val data.normal_min
        $("#result_text").val data.result_text
        $("#device").val data.device
        $("#description").val data.description
    update_url = '/phy_exam_tpls/update_item/'+tpl_item_id
    tpl_item_edit_new_form.action= update_url
    $("#for_edit").replaceWith '<div id="for_edit"><input name="_method" type="hidden" value="put" /></div>'
    padding tpl_item_id
    $('#select_category_item').find('option:not(:first)').remove();
    slt_category_item = $("#select_category_item")[0]
    $.get '/phy_exam_tpls/list_catagory_item/'+category_id, (data) ->
      slt_category_item.options.add(new Option(option[0], option[1])) for option in data
      $("#select_category_item option").each ->
        $(this).attr "selected", true  if $(this).val() == category_item_id
        $("#phy_exam_item_modal").modal show:true

  init : () ->
  	#edit modal for tpl_item_link
    $(".health_tpl_item_edit").click () ->
      category_id = $(this).attr("data-category-id")
      category_item_id = $(this).attr("data-category-item-id")
      tpl_item_id = $(this).attr("data-phy-exam-tpl-item")
      App.phy_exam_tpl_item_edit(category_id,tpl_item_id,category_item_id)
    #new modal for tpl_item_link
    $(".health_tpl_item_new").click ->
      tpl_id = $(this).attr("data-phy-exam-tpl-id")
      category_id = $(this).attr("data-catagory-id")
      tpl_item_edit_new_form.action = "/phy_exam_tpls/save_items"
      $("#for_edit").replaceWith '<div id="for_edit"></div>'
      $("#result_type_id").val "1"
      $("#num_type").hide()
      tpl_item_edit_new_form.reset()
      $("#phy_exam_tpl_id").val tpl_id
      $('#select_category_item').find('option:not(:first)').remove();
      slt_category_item = $("#select_category_item")[0]
      $.get '/phy_exam_tpls/list_catagory_item/'+category_id, (data) ->
        slt_category_item.options.add(new Option(option[0], option[1])) for option in data
        $("#phy_exam_item_modal").modal show: true
$(document).ready ->
  App.init()