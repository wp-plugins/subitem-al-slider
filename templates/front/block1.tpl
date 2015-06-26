<?php
  if (isset($front)&&(!empty($front))) : ?>
<?php  if ((isset($front[0])&&(!empty($front[0])))&&(isset($front[1])&&(!empty($front[1])))) : 
  $unq = "slider_".uniqid();
    $inner_sliders_slider = "";
      $containers_functions = "";
  
  global $sial_next_event_checking;
  
  $browser_exmp = new BrowserDetection();
    $browser = $browser_exmp->getBrowser();
  switch ($browser)
    {
      case BrowserDetection::BROWSER_FIREFOX :
        $main_wrapper_class = "subitem_al_slider_outter";
        $little_class = "subitem-al-no-flick-little-firefox";
        $small_class = "subitem-al-no-flick-small";
        $elem_class = "subitem-al-no-flick-elem";
        $atom_class = "subitem-al-no-flick-atom-firefox";
        $ff_add_flip_class = 'subitem-al-no-flick-img-firefox';
        $mv_class = "";
        $brw = 'firefox';
      break;
      case BrowserDetection::BROWSER_SAFARI :
        $main_wrapper_class = "";
        $little_class = "subitem-al-no-flick-little-safari";
        $small_class = "";//subitem-al-no-flick-small-safari";
        $elem_class = "subitem-al-no-flick-elem-safari";
        $atom_class = "subitem-al-no-flick-atom-safari";
        $ff_add_flip_class = '';
        $mv_class = "";//subitem-al-no-flick-little-safari";
        $brw = 'safari';
      break;
      default:
        $main_wrapper_class = "subitem_al_slider_outter";
        $little_class = "subitem-al-no-flick-little";
        $small_class = "subitem-al-no-flick-small";
        $elem_class = "subitem-al-no-flick-elem";
        $atom_class = "subitem-al-no-flick-atom";
        $ff_add_flip_class = '';
        $mv_class = "";
        $brw = 'other';
      break;
      
    }

?>
<div>
<script>
  if (window.subitemal_grps === undefined)
    window.subitemal_grps = [];

 window.subitemal_grps['<?php echo $unq; ?>'] = [];
</script>
<?php
$group_vals = '';

if(!function_exists("out_groups_inside")) {  
function out_groups_inside($gr, $container_img_script, $counting, $ctnkey, $unq, $atom_class)
  {
    foreach ($gr as $gritem)
      {
        if (isset($gritem['imtype'])&&($gritem['imtype'] == 'img'))
          {
          ?>
          
    <?php
    $counting++;
    $container_img_script .= "
    <script>
    if (subitemal_fl_img == undefined)var subitemal_fl_img = [];
    if (subitemal_fl_img['".$unq."'] == undefined) subitemal_fl_img['".$unq."'] = [];
    if (subitemal_fl_img['".$unq."'][".$ctnkey."+".$counting."] == undefined) subitemal_fl_img['".$unq."'][".$ctnkey."+".$counting."] = true;

    function one_time_img()
    {
    //window.subitem_slides_nums.push(".$ctnkey.");
    if (window.subitemal_loaded_slides_imgs['".$unq."'][".$ctnkey."] == undefined)window.subitemal_loaded_slides_imgs['".$unq."'][".$ctnkey."] = [];

      window.subitemal_loaded_slides_imgs['".$unq."'][".$ctnkey."].push([\"subitem_al_imgs_".$unq."_".$counting."\", \"".$gritem['imimage']."\", \"#subitem_al_item_".$ctnkey."\", \"set\"]);
    }

        if (subitemal_fl_img['".$unq."'][".$ctnkey."+".$counting."]) { one_time_img();subitemal_fl_img['".$unq."'][".$ctnkey."+".$counting."]=false; }
    </script>
    ";
    ?>
          
          <?php
          if (isset($gritem['imurl'])&&(!empty($gritem['imurl'])))
            {
          ?>
          <div class="<?php echo $atom_class; ?> subitem_al_img <?php if (isset($gritem['imclasses_list']))echo $gritem['imclasses_list']; ?>" style='left:<?php echo $gritem['imoffsetleft']; ?>px;top:<?php echo $gritem['imoffsettop']; ?>px;width:<?php echo $gritem['imwidth']; ?>px;height:<?php echo $gritem['imheight']; ?>px;'>
                <a href='<?php echo $gritem['imurl']; ?>'><img alt="<?php if (isset($gritem['imname']))echo $gritem['imname']; ?>" src="<?php echo plugins_url("../../images/empty.gif", __FILE__); ?>" class=" noborder subitem_al_imgs_<?php echo $unq; ?>_<?php echo $counting; ?>" style='width:<?php echo $gritem['imwidth']; ?>px;height:<?php echo $gritem['imheight']; ?>px;'/></a>
          </div>
          <?php
            }
          else
            {
          ?>
          <div class="<?php echo $atom_class; ?> subitem_al_img <?php if (isset($gritem['imclasses_list']))echo $gritem['imclasses_list']; ?>" style='left:<?php echo $gritem['imoffsetleft']; ?>px;top:<?php echo $gritem['imoffsettop']; ?>px;width:<?php echo $gritem['imwidth']; ?>px;height:<?php echo $gritem['imheight']; ?>px;'>
                <img alt="<?php if (isset($gritem['imname']))echo $gritem['imname']; ?>" src="<?php echo plugins_url("../../images/empty.gif", __FILE__); ?>" class=" noborder subitem_al_imgs_<?php echo $unq; ?>_<?php echo $counting; ?>" style='width:<?php echo $gritem['imwidth']; ?>px;height:<?php echo $gritem['imheight']; ?>px;'/>
          </div>
          <?php
            }
          }
        if (isset($gritem['txtype'])&&($gritem['txtype'] == 'txt'))
          {
          ?>
          <?php
          if (isset($gritem['txurl'])&&(!empty($gritem['txurl'])))
            {
          ?>
                <div class=" noborder <?php echo $atom_class; ?> subitem_al_txt <?php if (isset($gritem['txclasses_list']))echo $gritem['txclasses_list']; ?>" style='background-color:<?php echo $gritem['bgcolor']; ?>;color:<?php echo $gritem['color']; ?>;font-size:<?php if (isset($gritem['txsize'])&&($gritem['txsize']>=0)) echo $gritem['txsize']; ?>pt;left:<?php if (isset($gritem['txoffsetleft'])&&(is_numeric($gritem['txoffsetleft']))) echo $gritem['txoffsetleft']; ?>px;top:<?php if (isset($gritem['txoffsettop'])&&(is_numeric($gritem['txoffsettop']))) echo $gritem['txoffsettop']; ?>px;width:<?php if (isset($gritem['txwidth'])&&($gritem['txwidth']>=0)) echo $gritem['txwidth']; ?>px;height:<?php if (isset($gritem['txheight'])&&($gritem['txheight']>=0)) echo $gritem['txheight']; ?>px;<?php if (isset($gritem['style'])&&(!empty($gritem['style']))) echo $gritem['style']; ?>'><a href='<?php echo $gritem['txurl']; ?>'><?php echo stripslashes($gritem['txtext']); ?></a></div>
          <?php
            }
          else
            {
          ?>
                <div class=" noborder <?php echo $atom_class; ?> subitem_al_txt <?php if (isset($gritem['txclasses_list']))echo $gritem['txclasses_list']; ?>"  style='background-color:<?php echo $gritem['bgcolor']; ?>;color:<?php echo $gritem['color']; ?>;font-size:<?php if (isset($gritem['txsize'])&&($gritem['txsize']>=0)) echo $gritem['txsize']; ?>pt;left:<?php if (isset($gritem['txoffsetleft'])&&(is_numeric($gritem['txoffsetleft']))) echo $gritem['txoffsetleft']; ?>px;top:<?php if (isset($gritem['txoffsettop'])&&(is_numeric($gritem['txoffsettop']))) echo $gritem['txoffsettop']; ?>px;width:<?php if (isset($gritem['txwidth'])&&($gritem['txwidth']>=0)) echo $gritem['txwidth']; ?>px;height:<?php if (isset($gritem['txheight'])&&($gritem['txheight']>=0)) echo $gritem['txheight']; ?>px;<?php if (isset($gritem['style'])&&(!empty($gritem['style']))) echo $gritem['style']; ?>'><?php echo stripslashes($gritem['txtext']); ?></div>
          <?php
            }
          }
      }
      return array($counting, $container_img_script);
  }
}
?>
<?php
  list($items, $moves) = $front;
?>

<?php
if (isset($items)&&(!empty($items)))
  {
    $apply_classes = "<style scoped type=\"text/css\">\n".stripcslashes($items['main']['apply_classes'])."\n</style>\n";
  
    ($items['main']['fullwidth']==0) ? $notfullwidth = 'true' : $notfullwidth = 'false';
    ($items['main']['fullscreen']==0) ? $notfullscreen = 'true' : $notfullscreen = 'false';

if (($notfullwidth == 'true')&&($notfullscreen == 'true'))
 {
  $halign = "";
  switch ($items['main']['halign'])
    {
    case 0 : $halign = "text-align:left;"; break;
    case 1 : $halign = "text-align:center;margin:0 auto;"; break;
    case 2 : $halign = "text-align:right;margin-left:auto;"; break;
    }
  $valign = "";
  switch ($items['main']['valign'])
    {
    case 0 : $valign = "vertical-align:top;";$valign2 = ""; break;
    case 1 : $valign = "vertical-align:middle;";$valign2 = ""; break;
    case 2 : $valign = "vertical-align:bottom;";$valign2 = ""; break;
    }
 }
 else
 {
  $halign = "margin:0px;padding:0px;";
  $valign = "";
  $valign2 = "";
 }
?>
<div class="subitem_al_wrapper <?php echo $main_wrapper_class; ?>"  id="subitem_al_wrapper_<?php echo $unq; ?>" style="display:none;overflow:hidden;">
  <div class="subitem_al_preloader" id="subitem_al_preloader_<?php echo $unq; ?>" style="position:relative;left:0px;top:0px;width:100%;height:100%;background-color:#000000;display:none;z-index:1220000;">
    <div class="subitem_al_preloader_inside" style="display:table-cell;vertical-align:middle;text-align:center;">
      <img alt="Preloader" src="<?php echo plugins_url("../../images/preloader2.gif", __FILE__); ?>" class="preloaded_image" style="width:100px;">
    </div>
  </div>

<div class="subitem_al_outter_wrapper" id="subitem_al_outter_wrapper_<?php echo $unq; ?>" style="width:<?php if (isset($items['main']['miwidth']))echo $items['main']['miwidth']; ?>px;height:<?php if (isset($items['main']['miheight']))echo $items['main']['miheight']; ?>px;">
<div class="subitem_al_outter_wrapper_slider" style="<?php echo $valign; ?>">
<div class="subitem_al_outter_wrapper_slider_inside" style="<?php echo $valign2; ?><?php echo $halign; ?>">
<div class="subitem_al_wrapper_slider" id="subitem_al_wrapper_slider_<?php echo $unq; ?>" style="<?php echo $halign; ?>position:relative;left:<?php if (isset($items['main']['activeoffsetleft']))echo $items['main']['activeoffsetleft']; ?>px;top:<?php if (isset($items['main']['activeoffsettop']))echo $items['main']['activeoffsettop']; ?>px;width:<?php if (isset($items['main']['activewidth']))echo $items['main']['activewidth']; ?>px;height:<?php if (isset($items['main']['activeheight']))echo $items['main']['activeheight']; ?>px;">
  <div class="slide_processing" id="slide_processing_<?php echo $unq; ?>">
  </div>
  <div>
 <?php echo $apply_classes; ?>
  <div class="subitem_al_slider_main" id="subitem_al_slider_main_<?php echo $unq; ?>" style="width:<?php if (isset($items['main']['activewidth']))echo $items['main']['activewidth']; ?>px;height:<?php if (isset($items['main']['activeheight']))echo $items['main']['activeheight']; ?>px;">
<?php  $main_slider = "window.main_slider.push($('#subitem_al_slider_main_".$unq."').insidergall({action:'".$items['main']['mieffect']."', direction:'".$items['main']['mieffectdir']."', offsetX:'0px', offsetY:'0px', duration:".$items['main']['mide'].", duration_action:".$items['main']['midur'].", frame:'parent', zindex:2, actions_container:container['".$unq."'], inner_sliders: subitem_al_slidergalls['".$unq."'], set_buttons:".$items['main']['settings_buttons'].", set_top_buttons:".$items['main']['settings_buttons_top'].", set_width_buttons:".$items['main']['settings_buttons_width'].", set_opacity_buttons:".$items['main']['settings_buttons_opacity'].", unq:'".$unq."', set_indicators:".$items['main']['settings_indicators'].", set_top_indicators:".$items['main']['settings_indicators_top'].", set_width_indicators:".$items['main']['settings_indicators_width'].", indicators_num:".$items['main']['settings_num_indicators'].", atom: '".$atom_class."', brw: '".$brw."', flip_class: '".$ff_add_flip_class."'}));"; 

  $container_child_script = "";
  $container_main_script = "";
  $counting = 0;
?>

<?php
$hide_all_moves_this_container_main_func = "if (window.hide_not_current_moves == undefined)window.hide_not_current_moves = [];
                                            window.hide_not_current_moves['".$unq."'] = function(current_ctn) { 
                                            \n";
$hide_all_moves_this_container_invoke = "";

foreach ($items['containers'] as $ctnkey=>$ctn)
  {
    $inner_sliders_slider .= "subitem_al_slidergalls['".$unq."']['#subitem_al_slider".$ctnkey."'] = $('#subitem_al_slider".$ctnkey."').insidergall({action:'".$ctn['ctneffect']."',direction:'".$ctn['ctneffectdir']."', offsetX:'".$ctn['offset_left_inner']."px', offsetY:'".$ctn['offset_top_inner']."px', duration:".$ctn['duration_effect_inner'].", duration_action:".$ctn['ctndur'].", frame:'child', zindex:2, atom: '".$atom_class."', brw: '".$brw."', flip_class: '".$ff_add_flip_class."'});\n";
  ?>
    <?php
    $container_main_script .= "
    <script>
    if (subitemal_fl_bg == undefined)var subitemal_fl_bg = [];
    if (subitemal_fl_bg['".$unq."'] == undefined) subitemal_fl_bg['".$unq."'] = [];
    if (subitemal_fl_bg['".$unq."'][".$ctnkey."] == undefined) subitemal_fl_bg['".$unq."'][".$ctnkey."] = true;

    function one_time_bg()
    {
    window.subitemal_slides_nums.push(".$ctnkey.");
    if (window.subitemal_loaded_slides_imgs == undefined)window.subitemal_loaded_slides_imgs = [];
    if (window.subitemal_loaded_slides_imgs['".$unq."'] == undefined)window.subitemal_loaded_slides_imgs['".$unq."'] = [];
    if (window.subitemal_loaded_slides_imgs['".$unq."'][".$ctnkey."] == undefined)window.subitemal_loaded_slides_imgs['".$unq."'][".$ctnkey."] = [];

      window.subitemal_loaded_slides_imgs['".$unq."'][".$ctnkey."].push([\"subitem_al_bgs_".$unq."_".$ctnkey."\", \"".$ctn['bgimage']."\", \"#subitem_al_item_".$ctnkey."\", \"set\"]);
    }
        if (subitemal_fl_bg['".$unq."'][".$ctnkey."]) { one_time_bg();subitemal_fl_bg['".$unq."'][".$ctnkey."]=false; }
    </script>
    ";
    ?>

 <div id="subitem_al_item_<?php echo $ctnkey; ?>" class="<?php echo $little_class; ?> subitem_al_item subitem_al_item_<?php echo $unq; ?>_<?php echo $ctnkey; ?>" style="width:<?php if (isset($items['main']['activewidth']))echo $items['main']['activewidth']; ?>px;height:<?php if (isset($items['main']['activeheight']))echo $items['main']['activeheight']; ?>px;">

   <div id="subitem_al_subitem_<?php echo $ctnkey; ?>_01"  class="<?php echo $small_class; ?> subitem_al_subitem" style="width:<?php if (isset($items['main']['activewidth']))echo $items['main']['activewidth']; ?>px;height:<?php if (isset($items['main']['activeheight']))echo $items['main']['activeheight']; ?>px;">

          <?php
          if (isset($ctn['bgurl'])&&(!empty($ctn['bgurl'])))
            {
          ?>
          <a href='<?php echo $ctn['bgurl']; ?>'><img alt="<?php echo $ctn['bgname']; ?>" class="subitem_al_bgs_<?php echo $unq; ?>_<?php echo $ctnkey; ?>" src="<?php echo plugins_url("../../images/empty.gif", __FILE__); ?>" style="width:<?php if (isset($items['main']['activewidth']))echo $items['main']['activewidth']; ?>px;height:<?php if (isset($items['main']['activeheight']))echo $items['main']['activeheight']; ?>px;"></a>
          <?php
            }
          else
            {
          ?>
          <img alt="<?php echo $ctn['bgname']; ?>" class="subitem_al_bgs_<?php echo $unq; ?>_<?php echo $ctnkey; ?>" src="<?php echo plugins_url("../../images/empty.gif", __FILE__); ?>" style="width:<?php if (isset($items['main']['activewidth']))echo $items['main']['activewidth']; ?>px;height:<?php if (isset($items['main']['activeheight']))echo $items['main']['activeheight']; ?>px;">
          <?php
            }
            ?>
    
   </div>
      <div id="subitem_al_subitem_<?php echo $ctnkey; ?>_02"  class="<?php echo $small_class; ?> subitem_al_subitem"> <!--style="display:none;"-->
       <div class="subitem_al_slider-wrapper <?php echo $small_class; ?>">
        <div id="subitem_al_slider<?php echo $ctnkey; ?>" class="<?php echo $small_class; ?>">
<?php
if ((isset($ctn['groups'])&&(is_array($ctn['groups'])&&(!empty($ctn['groups'])))))
  foreach ($ctn['groups'] as $gr)
    {
    $maxwidth = 0;
    $maxheight = 0;
    foreach ($gr as $gritem)
      {
        if (isset($gritem['imtype'])&&($gritem['imtype'] == 'img'))
          {
          if ($maxwidth < $gritem['imwidth'])
            {
            $maxwidth = $gritem['imwidth'];
            $maxheight = $gritem['imheight'];
            }
          }
      }
    ?>
          <div class="subitem_al_slide1 <?php echo $small_class; ?>" style="width:<?php if (isset($maxwidth))echo $maxwidth; ?>px;height:<?php if (isset($maxheight))echo $maxheight; ?>px;">
<?php
  list($counting, $container_child_script) = out_groups_inside($gr, $container_child_script, $counting, $ctnkey, $unq, $atom_class);
      ?>
      </div>
      
<?php
    }
    ?>
      </div>
    
        </div>
          </div>
    
      <div id="subitem_al_subitem_<?php echo $ctnkey; ?>_03"  class="subitem_al_subitem subitem_al_subitem_moves">
<?php
           $containers_functions .= "
           subitem_al_item_".$ctnkey." : function()
            {
            var current_iteraction = window.stop_all_animations['".$unq."'];
            window.hide_not_current_moves['".$unq."'](".$ctnkey.");
              
            var hide_all = function(container, type)
              {
              if ($(container).children().length > 0)
                $(container).children().each(function (i,v){ if ( v != undefined) { (type) ? $(v).hide() : $(v).show(); } });
              }
            var anim_close = function(container)
              {
              if (( container != undefined)&&(container.children().length > 0))
                              container.children().find(':animated').stop(true, true);
                return true;
              }

      //$.fn.sequence_entf_base.set_transform_style('#subitem_al_subitem_".$ctnkey."_03');
            
            if (".$items['main']['slide_processing']." == 1)
            $.when($.fn.sequence_entf_base.slide_processing_add('".plugins_url("../../images/slide_processing.png", __FILE__)."', 30, '#slide_processing_".$unq."')).done(function(){
              $.fn.sequence_entf_base.slide_processing_time(30, ".$items['main']['midur'].");
            });
              
            var transition_methods = ['-webkit-transform', '-moz-transform', '-o-transform', '-ms-transform', 'transform'];
              
            $.when(anim_close($('#subitem_al_subitem_".$ctnkey."_03'))).done(function(){
            $.when($('#subitem_al_subitem_".$ctnkey."_03').html('').html(window.subitemal_grps['".$unq."']['#subitem_al_subitem_".$ctnkey."_03'])).done(function(){

            ";
        $hide_all_moves_this_container_start = "if (hide_moves_this_container['".$unq."'] == undefined)
                                                                                  hide_moves_this_container['".$unq."'] = [];
                                                    hide_moves_this_container['".$unq."'][".$ctnkey."] = function(num_not) {
                                                    if (num_not == ".$ctnkey.")return; \n";
        $hide_all_moves_this_container_end = " } \n";
        $hide_all_moves_this_container_invoke .= "hide_moves_this_container['".$unq."'][".$ctnkey."](current_ctn); \n";
        $hide_all_moves_this_container = "";
        
        foreach ($moves[$ctnkey]['moves'] as $mv)
          {
        $hide_all_moves_this_container .= "  $('".$mv['id_selector']."').css('display', 'none');\n";
        $containers_functions_end = "";
        
          if (isset($mv['groups']))
            {
           if (!empty($mv['mvurl'])) echo "<a href='".$mv['mvurl']."'>";
              echo "<div class='".$mv_class." noborder ".$elem_class."'><div class='noborder subitem_al_group_elem ".substr($mv['id_selector'],1)."' style='display:none;'>";
            foreach ($mv['groups'] as $grp_by_id)
             {
                  list($counting, $container_child_script) = out_groups_inside($grp_by_id, $container_child_script, $counting, $ctnkey, $unq, $atom_class);
             }
             if (!empty($mv['mvurl'])) echo "</a>";
              echo "</div></div>";
            }
        if (isset($mv['id_selector'])&&(!empty($mv['id_selector'])))
        {
        $rotate = $mv['start_rotation_out'];
          $rotate3d = $mv['start_rotation3d_out'];
            $scale3d = $mv['start_scale3d_out'];
              $translate3d = $mv['start_translate3d_out'];
           $containers_functions .= "  

      $('".$mv['id_selector']."').css('position', 'absolute');

      $('".$mv['id_selector']."').css({left : ".$mv['start_posxin']."});
      $('".$mv['id_selector']."').css({top : -1*(".$mv['mvheight']."+10)});
      
      $('".$mv['id_selector']."').css({width : ".$mv['mvwidth']."});
      $('".$mv['id_selector']."').css({height : ".$mv['mvheight']."});

      //$.fn.sequence_entf_base.set_perspective('".$mv['id_selector']."', ".$mv['perspective'].");

//$.fn.sequence_entf_base.set_opacity('".$mv['id_selector']."', 1);
$('.".substr($mv['id_selector'],1)."').css('display', 'block');

$.fn.stayinsidedelay('".$mv['id_selector']."', ".$mv['start_delay'].");

setTimeout(function(){
      $('".$mv['id_selector']."').promise().done(function() {



  if (current_iteraction < window.stop_all_animations['".$unq."'])
  { 
  //$('".$mv['id_selector']."').css('display', 'none');
  return true;
    }
";
$containers_functions_end = " }); }, ".$sial_next_event_checking."); " . $containers_functions_end;
$containers_functions .= "
$.fn.sequence_entf_base.unset_duration('".$mv['id_selector']."');
  $.fn.enteralsequence({id_selector:'".$mv['id_selector']."', id_parent_selector:
  '#'+$('#subitem_al_wrapper_".$unq."').find('".$mv['id_parent_selector']."').attr('id'),
    init_val:'".$mv['start_method']."',from_posx:".$mv['start_posxin'].", from_posy:".$mv['start_posyin'].",
      posx:".$mv['start_posxout'].", posy:".$mv['start_posyout'].", opacity:[(".$mv['start_opacityin']."/100),
        (".$mv['start_opacityout']."/100)], size:(".$mv['start_size']."/100), 
        rotate:[".$mv['start_rotation'].",".$mv['start_rotation_out']."],
        rotate3d:['".$mv['start_rotation3d']."','".$mv['start_rotation3d_out']."'],
        scale3d:['".$mv['start_scale3d']."','".$mv['start_scale3d_out']."'],
        translate3d:['".$mv['start_translate3d']."','".$mv['start_translate3d_out']."'],
          rotate_origin:'".$mv['start_rotation_origin']."', easing:'".$mv['start_easing']."',
           duration:".$mv['start_duration'].", transform3d_origin:'".$mv['start_transform3d_origin']."',
           transform_method:".$mv['start_transform_method'].", start_delay:".$mv['start_delay']."});

  if (current_iteraction < window.stop_all_animations['".$unq."'])
  { 
  //$('".$mv['id_selector']."').css('display', 'none');
  return true;
    }

    ";
    if ($mv['start_transform_method'] == 2)
          {
        $containers_functions .=  "
        setTimeout(function(){
        $('".$mv['id_selector']."').on('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', function(event){

        if ($.inArray(event.originalEvent.propertyName, transition_methods) != -1)
         {
          $('".$mv['id_selector']."').off('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd');
        ";
          $containers_functions_end = " } }); }, ".$sial_next_event_checking."); " . $containers_functions_end;
          }
        else
          {
            $containers_functions .= "
   setTimeout(function(){
            $('".$mv['id_selector']."').promise().done(function( ) {
  if (current_iteraction < window.stop_all_animations['".$unq."'])
  { 
  //$('".$mv['id_selector']."').css('display', 'none');
  return true;
    }

            ";
          $containers_functions_end .= "  }); }, ".$sial_next_event_checking."); ";
          }


  foreach ($mv['move_points'] as $mvp)
     {
    if (isset($mvp['method'])&&(!empty($mvp['method'])))
        {
     switch ($mvp['method'])
      {
      case 'move_point' :
     $containers_functions .= "
     $.fn.sequence_entf_base.unset_duration('".$mv['id_selector']."');
      $.fn.moveinside('".$mv['id_selector']."', ".$mvp['posx'].", ".$mvp['posy'].",
       ".$mvp['posxout'].", ".$mvp['posyout'].", ".$mvp['duration'].",
       '".$mvp['easing']."', (".$mvp['opacity']."/100), (".$mvp['mpsize']."/100),
        [".$rotate.",".$mvp['rotation']."],
        ['".$rotate3d."','".$mvp['rotation3d']."'],
        ['".$scale3d."','".$mvp['scale3d']."'],
        ['".$translate3d."','".$mvp['translate3d']."'],
        '".$mvp['rotation_origin']."', '".$mvp['transform3d_origin']."', ".$mvp['transform_method'].");\n";
        
    if ($mvp['transform_method'] == 2)
          {
        $containers_functions .=  "
       setTimeout(function(){
        $('".$mv['id_selector']."').on('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', function(event){

        if ($.inArray(event.originalEvent.propertyName, transition_methods) != -1)
         {
          $('".$mv['id_selector']."').off('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd');
        ";
          $containers_functions_end = " } }); }, ".$sial_next_event_checking."); " . $containers_functions_end;
          }
        else
          {
            $containers_functions .= "
   setTimeout(function(){
            $('".$mv['id_selector']."').promise().done(function( ) {";
            $containers_functions_end = " }); }, ".$sial_next_event_checking."); " . $containers_functions_end;
          }

          $rotate = $mvp['rotation'];
            $rotate3d = $mvp['rotation3d'];
              $scale3d = $mvp['scale3d'];
                $translate3d = $mvp['translate3d'];
            break;
      case 'delay_point' : 
     $containers_functions .= "
     $.fn.sequence_entf_base.unset_duration('".$mv['id_selector']."');
      $.fn.stayinsidedelay('".$mv['id_selector']."', ".$mvp['duration'].");

   setTimeout(function(){
                $('".$mv['id_selector']."').promise().done(function() {
  if (current_iteraction < window.stop_all_animations['".$unq."'])
  { 
  //$('".$mv['id_selector']."').css('display', 'none');
  return true;
    }

                "; 
                $containers_functions_end = " }); }, ".$sial_next_event_checking."); " . $containers_functions_end;
                break;
       }
        }
      }

   $containers_functions .= "
$.fn.sequence_entf_base.unset_duration('".$mv['id_selector']."');

            $.fn.finishalsequence({id_selector:'".$mv['id_selector']."', id_parent_selector:
            '#'+$('#subitem_al_wrapper_".$unq."').find('".$mv['id_parent_selector']."').attr('id'),
             init_val:'".$mv['finish_method']."',posx:".$mv['finish_posxin'].", posy:".$mv['finish_posyin'].",
             to_posx:".$mv['finish_posxout'].", to_posy:".$mv['finish_posyout'].",
              opacity:(".$mv['finish_opacity']."/100), size:(".$mv['finish_size']."/100), 
              rotate:[".$rotate.",".$mv['finish_rotation']."],
                rotate3d:['".$rotate3d."','".$mv['finish_rotation3d']."'],
                scale3d:['".$scale3d."','".$mv['finish_scale3d']."'],
                translate3d:['".$translate3d."','".$mv['finish_translate3d']."'],

               rotate_origin:'".$mv['finish_rotation_origin']."', easing:'".$mv['finish_easing']."',
                duration:".$mv['finish_duration'].", transform3d_origin:'".$mv['finish_transform3d_origin']."',
                transform_method:".$mv['finish_transform_method']."});
      ";

    if ($mv['finish_transform_method'] == 2)
          {
        $containers_functions .=  "
       setTimeout(function(){
        $('".$mv['id_selector']."').on('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', function(event){

        if ($.inArray(event.originalEvent.propertyName, transition_methods) != -1)
         {
         //$('".$mv['id_selector']."').css('display', 'none');
          $('".$mv['id_selector']."').off('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd');
        ";
          $containers_functions_end = " } }); }, ".$sial_next_event_checking."); " . $containers_functions_end;
          }
        else
          {
            $containers_functions .= "
   setTimeout(function(){
            $('".$mv['id_selector']."').promise().done(function( ) {
            //$('.".substr($mv['id_selector'],1)."').css('display', 'none');
            ";
            $containers_functions_end = " }); }, ".$sial_next_event_checking."); " . $containers_functions_end;
          }

  $containers_functions .= "
  if (current_iteraction < window.stop_all_animations['".$unq."'])
  { 
  return true;
    }

       
" . $containers_functions_end;

              }
            }
    $group_vals .= "//window.subitemal_grps['".$unq."']['#subitem_al_subitem_".$ctnkey."_03'] = $('#subitem_al_subitem_".$ctnkey."_03').html();\n";
        $containers_functions .= "  
                        });
                     });
            },
           ";
           $hide_all_moves_this_container_main_func .= $hide_all_moves_this_container_start . $hide_all_moves_this_container . $hide_all_moves_this_container_end;
    ?>

     </div>
    </div>
<?php
  }
  $hide_all_moves_this_container_main_func .= " ".
                                              $hide_all_moves_this_container_invoke . "
                                              } \n";
?>
  </div>
  </div>
<div id="subitem_slides_indicator_<?php echo $unq; ?>" class="slides_indicator" style="position:absolute;z-index:1000;"></div>
</div>
</div>

</div>
</div>

</div>
<script>

  if (window.subitem_loaded_slides_imgs == undefined)window.subitem_loaded_slides_imgs = [];
  if (window.subitem_loaded_slides_imgs['<?php echo $unq; ?>'] == undefined)window.subitem_loaded_slides_imgs['<?php echo $unq; ?>'] = [];
  if (window.subitemal_slides_nums == undefined)window.subitemal_slides_nums = [];
  
  if (window.subitem_slides_nums == undefined)window.subitem_slides_nums = [];
  
</script>

<?php echo $container_main_script; ?>
<?php echo $container_child_script; ?>

<?php } ?>
<div class="class_for_out_styles_sequence_<?php echo $unq; ?>">
</div>
<div class="stop_transition_<?php echo $unq; ?>">
</div>

<script>

if (hide_moves_this_container === undefined) var hide_moves_this_container = [];

if (window.subitemal_koefficient === undefined) window.subitemal_koefficient = [];
if (window.subitemal_koefficient['<?php echo $unq; ?>'] == undefined)window.subitemal_koefficient['<?php echo $unq; ?>'] = 1;

if (window.stop_all_animations === undefined) window.stop_all_animations = [];
if (window.stop_all_animations['<?php echo $unq; ?>'] == undefined)window.stop_all_animations['<?php echo $unq; ?>'] = 1;

if (window.delay_resize_flag === undefined) window.delay_resize_flag = [];
if (window.delay_resize_flag['<?php echo $unq; ?>']==undefined)window.delay_resize_flag['<?php echo $unq; ?>'] = true;

if (window.cont_width_curr === undefined) window.cont_width_curr = [];
      window.cont_width_curr['<?php echo $unq; ?>'] = jQuery('#subitem_al_wrapper_<?php echo $unq; ?>').parent().innerWidth();
      
    jQuery('#subitem_al_wrapper_<?php echo $unq; ?>').innerHeight(jQuery('#subitem_al_wrapper_<?php echo $unq; ?>').parent().innerWidth()*<?php echo $items['main']['activeheight']; ?>/<?php echo $items['main']['activewidth']; ?>);

jQuery( document ).ready(function($) {

if (window.main_slider === undefined) window.main_slider = [];
if (subitem_al_slidergalls === undefined) var subitem_al_slidergalls = [];

 subitem_al_slidergalls['<?php echo $unq; ?>'] = [];
<?php if (isset($inner_sliders_slider)&&(!empty($inner_sliders_slider))) {
  echo $inner_sliders_slider;
  }
  ?>

if (container === undefined) var container = [];

 container['<?php echo $unq; ?>'] = {
<?php if ((isset($containers_functions))&&(!empty($containers_functions)))
echo $containers_functions;
 ?>
 additional : function()
 {
 
 }
}

<?php if (isset($main_slider)&&(!empty($main_slider))) {
  echo $main_slider;
  }
  ?>

$.fn.sequence_entf_base.add_indexOf();

if ((wsbi == undefined)||(window.subitemal_slide_by_index == undefined))
  var wsbi = window.subitemal_slide_by_index = function(unq, ind)
    {
    if (window.main_slider != undefined)
       $.each(window.main_slider, function (i, v){ 
       
        if (v.unq == unq)
          {
            v.slide_to_position(ind);
          }
       
       });
    }

//Preloader load
var image = new Image();
image.onload = function () {
var myElement = $("#subitem_al_wrapper_<?php echo $unq; ?>");
  myElement.show();

if (window.subitemal_loaded_slides != undefined)
  window.subitemal_loaded_slides(window.subitemal_slides_nums[0], true);
  else
  wsbi('<?php echo $unq; ?>', window.subitemal_slides_nums[0]);
}
image.onerror = function () {
   console.error("Incorret image loading");
}
image.src = '<?php echo plugins_url("../../images/preloader2.gif", __FILE__); ?>';

$( "body" ).on( "main_func", function( event ) {

<?php echo $hide_all_moves_this_container_main_func; ?>

<?php echo $group_vals; ?>


if (win_common_width === undefined) var win_common_width = [];
if (win_common_width['<?php echo $unq; ?>']==undefined) win_common_width['<?php echo $unq; ?>'] = $(window).outerWidth();
 
 if (doc_start_only_width === undefined) var doc_start_only_width = [];
 if (doc_start_only_width['<?php echo $unq; ?>'] == undefined) doc_start_only_width['<?php echo $unq; ?>'] = $(document).outerWidth();
   
 if (win_init_width === undefined) var win_init_width = [];
 if (win_init_width['<?php echo $unq; ?>'] == undefined) win_init_width['<?php echo $unq; ?>'] = $('#subitem_al_outter_wrapper_<?php echo $unq; ?>').outerWidth();
     
 if (init_koef === undefined) var init_koef = [];
       if (init_koef['<?php echo $unq; ?>'] == undefined)init_koef['<?php echo $unq; ?>'] = doc_start_only_width/win_common_width;
       
 if (fl === undefined) var fl = [];
        if (fl['<?php echo $unq; ?>'] == undefined)fl['<?php echo $unq; ?>'] = true;

 if (koef === undefined) var koef = [];
     koef['<?php echo $unq; ?>'];

 if (notfullwidth === undefined) var notfullwidth = [];
  if (notfullwidth['<?php echo $unq; ?>'] == undefined) notfullwidth['<?php echo $unq; ?>'] = <?php echo $notfullwidth; ?>;

 if (notfullscreen === undefined) var notfullscreen = [];
     if (notfullscreen['<?php echo $unq; ?>'] == undefined)notfullscreen['<?php echo $unq; ?>'] = <?php echo $notfullscreen; ?>;
    
window.subitemal_koefficient['<?php echo $unq; ?>'] = koef['<?php echo $unq; ?>'] = $.fn.resizing_by_outterbox('#subitem_al_outter_wrapper_<?php echo $unq; ?>', win_common_width['<?php echo $unq; ?>'], win_init_width['<?php echo $unq; ?>'], <?php echo $notfullscreen; ?>, <?php echo $notfullwidth; ?>, doc_start_only_width['<?php echo $unq; ?>'], init_koef['<?php echo $unq; ?>']);
$.fn.resizing_outter_divs(koef['<?php echo $unq; ?>'], ['#subitem_al_outter_wrapper_<?php echo $unq; ?>'], ['#subitem_al_wrapper_<?php echo $unq; ?>']);

        $.each(window.main_slider, function(i, v){
        if (( v != undefined)&&(v.unq == '<?php echo $unq; ?>'))
          {
            v.resize_additional(koef['<?php echo $unq; ?>']);
          }
        });

  win_common_width['<?php echo $unq; ?>'] = $(window).outerWidth();

if (window.allownow_outter === undefined) window.allownow_outter = []; 
 window.allownow_outter['<?php echo $unq; ?>'] = true;

 if (stop_all_seq === undefined) 
  var stop_all_seq = function(){
  }

    var lastWindowHeight = 0;
    var lastWindowWidth = 0;
    
$( window ).resize(function() {
        if($(window).height()!=lastWindowHeight || $(window).width()!=lastWindowWidth){

            //set this windows size
            lastWindowHeight = $(window).height();
            lastWindowWidth = $(window).width();
          
              current_resize();

         }
});

var current_resize = function() {
        $.each(window.main_slider, function(i, v){
        if ( v != undefined)
        {
        window.stop_all_animations[v['unq']]=window.stop_all_animations[v['unq']]+1;
        (!window.delay_resize_flag[v['unq']]) ? durate = v['duration'] : durate = 0;

         setTimeout(function(){
          $.when( stop_all_seq() ).done(function(){
           window.allownow_outter[v['unq']] = false;
              $.when( doneResizing(v) ).done(function(){
                  window.allownow_outter[v['unq']] = true;
             });
          });
         }, durate);
        }
        });
 }

function doneResizing(main_slider_single)
{
if (fl[main_slider_single['unq']])
  {
var has_childs = main_slider_single.isset_current_child();
    fl[main_slider_single['unq']] = false;
    
if (has_childs)
          main_slider_single.stop_current_child();

window.subitemal_koefficient['<?php echo $unq; ?>'] = koef[main_slider_single['unq']] = $.fn.resizing_by_outterbox('#subitem_al_outter_wrapper_'+main_slider_single['unq'], win_common_width[main_slider_single['unq']], win_init_width[main_slider_single['unq']], notfullscreen[main_slider_single['unq']], notfullwidth[main_slider_single['unq']], doc_start_only_width[main_slider_single['unq']], init_koef[main_slider_single['unq']]);

$.fn.resizing_outter_divs(koef[main_slider_single['unq']], ['#subitem_al_outter_wrapper_'+main_slider_single['unq']], ['#subitem_al_wrapper_'+main_slider_single['unq']]);
    win_common_width[main_slider_single['unq']] = $(window).outerWidth();

main_slider_single.resize_additional(koef[main_slider_single['unq']]);

  main_slider_single.reload();
    fl[main_slider_single['unq']] = true;

if (has_childs)
        main_slider_single.start_current_child();
  }
};

var focus_flag = false;

    $(window).on("blur focus", function(e) {

    var prevType = $(this).data("prevType");

        switch (e.type) {
            case "blur":

            focus_flag = true;
            $.each(window.main_slider, function (i, v) {
              v.stop();
                if (v.isset_current_child())
                        v.stop_current_child();

            });
                break;
            case "focus":

              focus_activate();
                break; 
        }

      $(this).data("prevType", e.type);
    });

var focus_activate = function() {
        if (focus_flag)
              {
                lastWindowHeight = 0;
                lastWindowWidth = 0;
                  $(window).trigger('resize');
              }
}
  

 });
});

</script>
</div>
  
<?php else : ?>
  <h3>Wrong Slider Project ID or some other troubles.</h3>
<?php endif; ?>
<?php endif; ?>
