
  <script>
jQuery(document).ready(function($) {
    
    $('#mass_effect').click( function() {
    
    var input = $("input[name='chk_now[]']").clone();
    $(".hidden_chk").append(input);
    
    });
    


    var effect_close_event = function(){
        $('.effect_element img').unbind("click").bind("click", function(event){
            event.preventDefault();
          $(this).parent().remove();
        });
    }
    
    $('button[name="apply_effect_name"]').click(function(event){
    event.preventDefault();
    var check_name_possibility = true;
    $('input[name="effects_names[]"]').each(function(i,v){
      if ($(v).val() == $("select[name='effect']").val())check_name_possibility = false;
    });
    if (check_name_possibility)
      $('.applied_effects').append("<div class='effect_element' style='line-height:30px;'><img src='<?php echo plugins_url("../images/close.png", __FILE__); ?>' class='close_effect_elem' style='cursor:pointer;'>&nbsp;&nbsp;&nbsp;"+$("select[name='effect']").val()+"<input type='hidden' name='effects_names[]' value='"+$("select[name='effect']").val()+"'></div>");

        effect_close_event();

    });

    effect_close_event();

  });
  </script>


<!-- ********************************************* Tab Page 1 ****************************************************** -->

  <div id="tabs-1">
<br>  
Background Images &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <button class="set_background_images">Upload</button>

