  <script>
jQuery(document).ready(function($) {

<?php
global $minicolors;
  if ($minicolors)
  {
  ?>
function set_color_pickers()
  {
  $.minicolors = {
    defaults: {
        animationSpeed: 50,
        animationEasing: 'swing',
        change: null,
        changeDelay: 0,
        control: 'hue',
        dataUris: true,
        defaultValue: '',
        hide: null,
        hideSpeed: 100,
        inline: false,
        letterCase: 'lowercase',
        opacity: false,
        position: 'bottom left',
        show: null,
        showSpeed: 100,
        theme: 'default'
    }
};
    $('input[name="color"]').not('.hdn_color').minicolors('create', $.minicolors.defaults);
    $('input[name="bgcolor"]').not('.hdn_color').minicolors('create', $.minicolors.defaults);
  }
  
  if ('<?php global $minicolors; echo ($minicolors) ? "true" : "false"; ?>' == 'true')
  set_color_pickers();
  <?php
  }
  ?>
    $('#image_mass_effect').click( function() {
    var input = $("input[name='image_chk_now[]']").clone();
    $(".hidden_chk_1").append(input);
    });

    $('#text_mass_effect').click( function() {
    var input = $("input[name='text_chk_now[]']").clone();
    $(".hidden_chk_2").append(input);
    });


    $("#txt_create").click(function(){
      $( ".new_text_item" ).show();
                  event.preventDefault();
    });
    
    $('.create_new_txt_btn').bind('click', function(event){
       if ($('#new_text_item').val() == '')
            {
            event.preventDefault();
              window.alert_show('Wrong item text', 'Error');
            }
            else
            {
            send_text_data($('#new_text_item').val(), $('select[name="slide_text"]').val());
              $('#new_text_item').val('');
                $( ".new_text_item" ).hide();
                            event.preventDefault();
            }
    });
    $('.close_new_txt_btn').unbind('click').bind('click', function(event){
              $('#new_text_item').val('');
                $( ".new_text_item" ).hide();
                            event.preventDefault();
    });

    $('#txt_create2').click( function() {

    $( ".new_text_item" ).dialog({
      resizable: false,
      height:140,
      modal: true,
      buttons: {
        "Create new text item": function() {

          if ($('#new_text_item').val() == '')
            {
            event.preventDefault();
            alert_show('Wrong item text', 'Error');
            }
            else
            {
            send_text_data($('#new_text_item').val());
            $('#new_text_item').val('');
            }
            
            $( this ).dialog( "close" );
        },
        Cancel: function() {
          $( this ).dialog( "close" );
        }
      }
    });
    
    });

var current_text_num = 1;

swp_num_text = parseInt($('#last_number_text').html(), 10);
  if (swp_num_text > 0)current_text_num = swp_num_text + 1;

  function send_text_data(text_data)
   {
  var url = ajaxurl;
  var nonce = $('#text_nonce').html();
  var info = $('#one_text_info').html();

    $.post( url, { action:"sial_saveTextData_ajax", id_main: $('#projects').val(), name: "", url: "", text: text_data, width: 0, height: 0, offsetleft: 0, offsettop: 0, id_container:0, num_in_container:0, txt_save_ajax: true, nonce: nonce })
    .done(function( nfo ) {
      var data = nfo.split("*");
          info = info.replace("[TEXT]", text_data);
            info = info.replace("[NUM]", current_text_num);
              info = info.replace('[TXTID]', '<input type="hidden" name="textid" value="'+data[0]+'">');
                info = info.replace(/\[TXTIDONLY\]/g, data[0]);
      info = info.replace("[GROUPPOS]", data[2]);
      info = info.replace("[GROUP]", make_select(data[1], data[3], 'txt'));
                
                current_text_num++;

      $('.text_items').append(info);
      $('.text_items').find('.hdn_color').removeClass('hdn_color');
        set_color_pickers();
           all_submits();
                $( "input[type='submit']" ).button();
      
      });
    }

    
  });
  </script>
  <div id="tabs-3">
<!-- ********************************************* Tab Page 3 ****************************************************** -->
 <div class="new_text_item" title="New text item creation" style="width:40%;/*border:1px solid black;background-color:#fff;width:350px;padding-left:20px;*/">

<div class="panel panel-primary">
<div class="panel-heading">
 
    <h3 class="panel-title">Create new text element<h3>
    
 </div>
<div class="panel-body">

    
    Text   <input type="text" name="new_text_item" value="" id="new_text_item">
    <input type="submit" class="create_new_txt_btn" value="Create">
    <input type="submit" class="close_new_txt_btn" value="Close">
    
     </div>
      </div>
      
 </div>
 
  <table>
  <tr>
  <td>
  <button name="img_create" id="img_create">Create New Image Item</button>
  </td>
  <td>
  <button name="txt_create" id="txt_create">Create New Text Item</button>
  </td>
  </tr>
  </table>
