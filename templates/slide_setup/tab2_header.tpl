<div><img src='<?php echo plugins_url("../../images/caption.png", __FILE__); ?>'></div>
  
<!-- ********************************************* Slide Setup ****************************************************** -->
  <script>
jQuery(document).ready(function($) {

    $( "input[type=submit], button" ).not(".hdn").button();

var current_container_num = 0;

swp_container_num = parseInt($('#last_number_container').html(), 10);
  if (swp_container_num > 0)current_container_num = swp_container_num;

    $('#create_container').click( function(event) {
        event.preventDefault();
           send_container_data();
      
    });
  groups = jQuery.parseJSON('<?php echo json_encode($group_info); ?>');
  var containers_img = jQuery.parseJSON('<?php echo json_encode($image_info); ?>');
  var containers_txt = jQuery.parseJSON('<?php echo json_encode($text_info); ?>');
  var num_containers = containers_img.length + containers_txt.length;
  var num_last_container;
  
  function send_container_data()
   {
  var url = ajaxurl;
  var nonce = $('#container_nonce').html();
  var info = $('.container_hidden_form').html();
      
    $.post( url, { action:"sial_saveContainerData_ajax", id_main: $('#projects').val(), bg_image: 0, effect: "", effect_direction: "", num: current_container_num, container_save_ajax: true, nonce: nonce })
    .done(function( data ) {
        current_container_num++;
            info = info.replace(/\[NUM\]/g, current_container_num);
                 info = info.replace(/\[CONTIDONLY\]/g, data);

    $('#last_number_container').html(current_container_num);
     var last_info = remove_class_hdn(info);
      $('.container_area').append(last_info);
           all_submits();
            renew_buttons(data);
      
      $('.create_item').unbind( "click" ).bind('click', function(event) {
          send_item_data($(this), event);
        });
        
      $('.create_singleitem').unbind( "click" ).bind('click', function(event) {
          send_singleitem_data($(this), event);
        });
        
      $('.up_btn').unbind( "click" ).bind('click', function(event) {
          move_item_up($(this).parent().parent(), event);
        });
      $('.down_btn').unbind( "click" ).bind('click', function(event) {
          move_item_down($(this).parent().parent(), event);
        });
        
      });
      
    }
function renew_buttons(conid)
{
              $( ".container_box_"+conid).find( "input[type='submit']" ).not(".hdn").each(function(k, item){
              try {
                    $(item).button('destroy');
                  } catch (exception) {}
                $(item).button();
                });
              $( ".container_box_"+conid).find( "button" ).not(".hdn").each(function(k, item){
              
              try {
                    $(item).button('destroy');
                  } catch (exception) {}
                 
                $(item).button();
                });
}
  function send_item_data(elem, event)
   {
  var url = ajaxurl;
  var nonce = $('#item_nonce').html();

      var id = elem.attr("id");
      var id_arr = id.split("item_");
      
      num_items = $("input[name='num_items_"+id_arr[1]+"']").val();

    $.post( url, { action:"sial_saveItemData_ajax", id_container: parseInt(id_arr[1],10), id_group: 0, type: "image", num: num_items, item_save_ajax: true, nonce: nonce })
    .done(function( data ) {
        create_item(elem, data, event);
      });
   }

var num_items;

function delete_item(elem, event)
  {
    var cur_elem = elem;
    var url = ajaxurl;
      var nonce = $('#item_nonce').html();
      id_curr = cur_elem.val().split(":");
      if (id_curr[0] == "erase")
            {
              $.post( url, { action:"sial_delItemData_ajax", itemid: parseInt(id_curr[1],10), item_del_ajax: true, nonce: nonce })
              .done(function( data ) {

                cur_elem.remove();
              });
            }
  }

function create_item(elem, data, event)
  {  
    event.preventDefault();
      var id = elem.attr("id");
      var id_arr = id.split("item_");
      
      var info = '<select class="item_sel_box" name="item_selectbox[]">';
        num_containers++;

        $.each(groups, function(k, im) {
          info += "<option value='"+data+":"+im['id']+":"+num_items+"'>"+im['name']+"(#"+im['id']+")</option>"
        });

        info += "<option value='erase:"+data+"'>Delete</option></select>";

      $('#container_creation_area_'+id_arr[1]).append(info);
      
    $('.item_sel_box').unbind( "change" );
    $('.item_sel_box').bind('change', function() {
      delete_item($(this), event);
    });
    
    num_items++;
      $("input[name='num_items_"+id_arr[1]+"']").val(num_items);
  }
function move_item_up(elem, event)
  {
    event.preventDefault();
    var fldname = elem.attr("class").split("box_");
    
    elem.insertBefore(elem.prev());
  }
function move_item_down(elem, event)
  {
    event.preventDefault();
    var fldname = elem.attr("class").split("box_");
    
    elem.insertAfter(elem.next());
  }

//*********************
    $('.create_item').unbind( "click" ).bind('click', function(event) {
          send_item_data($(this), event);
      });
      $('.create_singleitem').unbind( "click" ).bind('click', function(event) {
          send_singleitem_data($(this), event);
        });

      $('.add_move_point').unbind( "click" ).bind('click', function(event) {
          send_move_delay_point_data($(this),'move_point', event);
        });
      $('.add_delay_point').unbind( "click" ).bind('click', function(event) {
          send_move_delay_point_data($(this),'delay_point', event);
        });

      $('.remove_point').unbind( "click" ).bind('click', function(event) {
            delete_move_delay_point_data($(this), event);
        });

    $('.item_sel_box').unbind( "change" ).bind('change', function(event) {
      delete_item($(this), event);
    });
    $('.up_btn').unbind( "click" ).bind('click', function(event) {
          move_item_up($(this).parent().parent(), event);
      });
    $('.down_btn').unbind( "click" ).bind('click', function(event) {
          move_item_down($(this).parent().parent(), event);
      });
    $('#save_containers_positions').unbind( "click" ).bind('click', function(event) {
       var nonce = $('#container_nonce').html();
         var current = $('.container_area').children().first();
         var ids = [];
            ids.push(current.attr("class").split("box_")[1]);
         do {
            current = current.next();
            var contid = current.attr("class").split("box_");
            ids.push(contid[1]);
         } while (current.attr("class") !=  $('.container_area').children().last().attr("class"))
      var url = ajaxurl;

              $.post( url, { action:"sial_saveContainersPositions_ajax", contid: ids, container_pos_ajax: true, nonce: nonce })
              .done(function( data ) {
                  location.href = "<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=1&pid="+$('#projects').val();
              });
      });
function get_id(elem, delim, event)
  {
    event.preventDefault();
      var id = elem.attr("id");
      var id_arr = id.split(delim);

    return id_arr;
  }
function send_singleitem_data(elem, event)
  {
      var id_arr = get_id(elem, "item_", event);
        add_singleitem_record(id_arr[1]);
  }
function getFirstKey( data ) {
        for (elem in data ) 
            return elem;
   }
function add_singleitem_record(contid)
  {
  var url = ajaxurl;
  var nonce = $('#move_nonce').html();
  
  var source = "none";//groups[getFirstKey(groups)].id;

    $.post( url, { action:"sial_saveMoveData_ajax", id_container: contid, source: source, move_save_ajax: true, nonce: nonce })
    .done(function( data ) {
    var info = $('.container_hidden_form_singleitem').html();
        info = info.replace(/\[MOVESID\]/g, data);
          var area = $('#container_creation_area_move_'+contid).andSelf().find(".accordion");
          var init_val = area.html();
                var last_info = remove_class_hdn(info);
            if (!$.trim(init_val))
              {
              area.remove();
              var cur_cont = $('#container_creation_area_move_'+contid);
                cur_cont.append("<div class='accordion'></div>");
                  cur_cont.andSelf().find(".accordion").append(last_info);
                  renew_accordion(cur_cont.andSelf().find(".accordion"));
              }
              else
              {
                area.append(last_info).accordion("refresh");
              }
              
                all_submits();
                  renew_buttons(contid);

      $('.add_move_point').unbind( "click" ).bind('click', function(event) {
          send_move_delay_point_data($(this),'move_point', event);
        });
      $('.add_delay_point').unbind( "click" ).bind('click', function(event) {
          send_move_delay_point_data($(this),'delay_point', event);
        });
      $('button[name="remove_accordion"]').unbind('click').bind('click', function(event){
          remove_move($(this), event);
        });

      });

  }
   var last_num_mptid = [];
function send_move_delay_point_data(elem, method, event)
  {
   var id_arr = get_id(elem, "point_", event);

      var mptid = parseInt(id_arr[1],10);
   if (!(mptid in last_num_mptid))
    {
      last_num_mptid[mptid] = parseInt($('#mplast_'+id_arr[1]).html(), 10)+1;

    }
      else
    {
      last_num_mptid[mptid] += 1;
    }
      
  var url = ajaxurl;
  var nonce = $('#move_nonce').html();
    $.post( url, { action:"sial_saveMovePointData_ajax", id_move: id_arr[1], method:method, movepoint_save_ajax: true, nonce: nonce })
    .done(function( data ) {

      switch (method)
        {
        case 'move_point' :
          var info = $('.move_point_hidden_form').html();
          break;
        case 'delay_point' :
          var info = $('.delay_point_hidden_form').html();
          break;
        }
        info = info.replace(/\[MOVEPOINT\]/g, data);

        info = info.replace(/\[MPNUM\]/g, last_num_mptid[mptid]);

          var area = $('#points_area_'+id_arr[1]).find(".points");
          var init_val = area.html();
                var last_info = remove_class_hdn(info);
                
            if (!$.trim(init_val))
              {
              area.remove();
              var cur_cont = $('#points_area_'+id_arr[1]);
                cur_cont.append("<div class='points'></div>");
                  cur_cont.andSelf().find(".points").append(last_info);
                  renew_accordion(cur_cont.andSelf().find(".points"));
              }
              else
              {
                area.append(last_info).accordion("refresh");
              }

           all_submits();

           var id_cont = get_id(elem.closest('.container_frm'), "frm_", event);
           
            renew_buttons(id_cont[1]);
            
      $('.remove_point').unbind( "click" ).bind('click', function(event) {
            delete_move_delay_point_data($(this), event);
        });

      });
      
    return false;
  }
function delete_move_delay_point_data(elem, event)
  {
   var id_arr = get_id(elem, "point_", event);

  var url = ajaxurl;
  var nonce = $('#move_nonce').html();
    $.post( url, { action:"sial_delMovePointData_ajax", id: id_arr[1], movepoint_del_ajax: true, nonce: nonce })
    .done(function( data ) {
      if (data == '1')
        $('#mpt_group_'+id_arr[1]).remove();
      });
  }

$('button[name="remove_accordion"]').unbind('click').bind('click', function(event){
  remove_move($(this), event);
});
function remove_move(elem, event)
  {
        var id_arr = get_id(elem, "accordion_", event);
        
  var url = ajaxurl;
  var nonce = $('#move_nonce').html();
    $.post( url, { action:"sial_delMoveRow_ajax", id: id_arr[1], move_del_ajax: true, nonce: nonce })
    .done(function( data ) {
      if (data == 1)
        {
          $('#sib_'+id_arr[1]).remove();
                  $(".accordion").accordion( "refresh" );
        }
      });
  }
//*********************
function renew_accordion(elem)
{
elem.accordion({
        header: "> div > h3",
        heightStyle: "content",
        collapsible: true,
        active: false,
      })
      .sortable({
        axis: "y",
        handle: "h3",
        stop: function( event, ui ) {
          // IE doesn't register the blur when sorting
          ui.item.children( "h3" ).triggerHandler( "focusout" );
 
          // Refresh accordion to handle new order
          $( this ).accordion( "refresh" );
        }
      });
}
renew_accordion($( ".accordion" ));
renew_accordion($(".points"));
//*********************

/*
Remove hdn class
*/
window.remove_class_hdn = function(source)
  {
    $(source).find(".hdn").each(function(key, item){
    var oldi = item.outerHTML;
    var newi = $(item).removeClass("hdn")[0].outerHTML;
      source = source.replace(oldi, newi);
    });
    return source;
  }
  
function validate_big_form(event, defselector, elem)
{
$('.container_frm__errors').html("");
var big_frm_errors = [];
  var id_arr = elem.attr("id").split("frm_");
  var selector = "#"+defselector.substr(1)+"_"+id_arr[1];
  $(selector).find(".notempty_fld").each(function (key,item) {
    if ((empty(item))||($(item).val() == ''))
      big_frm_errors.push("Validation Error (not empty check): Field - '"+$(item).parent().prev().html()+"'");
  });
  $(selector).find(".digits_fld").each(function (key,item) {
    if ((empty(item))||(!$.isNumeric($(item).val())))
      big_frm_errors.push("Validation Error (digit check): Field - '"+$(item).parent().prev().html()+"'");
  });

  if (big_frm_errors.length === 0)
              {

              }
              else
              {
              event.preventDefault();
              var newsel = selector+"_errors";
                $(newsel).html("<br>"+big_frm_errors.join("<br>"));
              }
}  

window.all_submits = function()
{
$('.container_frm').unbind('submit').bind('submit', function(event){
  validate_big_form(event, '.container_frm', $(this));
});
}
all_submits();

window.alert_show = function(msg, type)
  {
  $( "#dialog-message" ).html(msg);
  $( "#dialog-message" ).attr("title", type);
    $( "#dialog-message" ).dialog({
      modal: true,
      buttons: {
        Ok: function() {
          $( this ).dialog( "close" );
        }
      }
    });
  }
  
function empty(element) {
    if (
            element === ""          ||
            element === 0           ||
            element === "0"         ||
            element === null        ||
            element === "NULL"      ||
            element === "null"      ||
            element === undefined   ||
            element === false
        ) {
        return true;
    }
    if (typeof(element) === 'object') {
        var i = 0;
        for (key in element) {
            i++;
        }
        if (i === 0) { return true; }
    }
    return false;
}

  });
  </script>
<!--<button name="create_container" id="create_container">Create Container</button>-->
 <div id="move_nonce"><?php 
if (function_exists('wp_create_nonce'))
    {
echo wp_create_nonce("upd_rec_move");
    }
 ?></div>
 <div id="item_nonce"><?php 
if (function_exists('wp_create_nonce'))
    {
echo wp_create_nonce("upd_rec_item");
    }
 ?></div>
