<div class="container_hidden_form">
<div class="container_box_[CONTIDONLY]">
<div id="container_frm_[CONTIDONLY]_errors" class="container_frm__errors">

</div>

<div class="chk2">
  <div class="chk_in">
    <!--<input type="checkbox" name="container_chk_now[]" value="[CONTIDONLY]">-->
  </div>
</div>
<div class="mn_container">
  <h3>Container #[NUM]</h3>
    <div class="container_data">

<form method="POST" id="container_frm_[CONTIDONLY]" class="container_frm hdn" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=1&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&amp;updated=true">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_container');
    }
  ?>

<br>
<a href="<?php echo admin_url(); ?>admin.php?page=sial_slide&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&container=[CONTIDONLY]&num=[NUM]" target="_blank" style='float:right;font-weight:bold;'>Slide Setup >>></a>

<input type="hidden" name="pid" value="<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
<input type="hidden" name="num" value="[NUM]">
<input type="hidden" name="containerid" value="[CONTIDONLY]">
<input type="hidden" name="item_type" value="1"><!-- "1"-image -->

<input type="hidden" name="num_items_[CONTIDONLY]" value="1">
  <!--    <input type="submit" class="hdn" value=" Save this container " name="container_save_btn" data-role="button">-->
    <input type="submit" class="hdn" value=" Delete this container " name="container_del_btn" data-role="button">

  </form>

</div>

</div>

<div class="bottom_up_down">
<div class="up_btn"><img src='<?php echo plugins_url("../images/up.png", __FILE__); ?>'></div>
<div class="down_btn"><img src='<?php echo plugins_url("../images/down.png", __FILE__); ?>'></div>
</div>
<div class="clear_line"></div>
</div>
</div>

<div class="container_hidden_form_singleitem">
  <div class="singleitem_box" id="sib_[MOVESID]">
    <h3>Single element</h3>
    <div class="container_single_elements">
    <table>

    <tr>
    <td>
    Source
    </td><td>
    <select name="single[source][]" class="singleelem_groups">
    <?php
    foreach ($group_info as $gr)
      {
          echo "<option value='".$gr->id."'>".$gr->name."</option>";
      }
    ?>
    </select>

    </td>
    </tr>

    <tr>
    <td>
    Start delay
    </td><td>
    <input type="text" class="digits_fld" name="single[start_delay][]" value="0">
    </td>
    </tr>

    <tr>
    <td colspan="2">
    Use Method of manipulation
    </td>
    <td colspan="2">
    <select name="single[start_transform_method][]">
<?php
  $transform_methods = array(1=>'Use animation', 2=>'Use transition');
  foreach ($transform_methods as $tm_key=>$tm)
    {
 ?>
    <option value="<?php echo $tm_key; ?>" <?php if (1 == $tm_key)echo 'selected="selected"'; ?>><?php echo $tm; ?></option>
    <?php
    }
    ?>
    </select>
    </td>
    </tr>

    
    <tr>
    <td>
    Name
    </td><td>
    <input type="text" name="single[name][]" value="">
    </td>
    <td>
    Url
    </td><td>
    <input type="text" name="single[url][]" value="">
    </td>
    <td>
    Start size
    </td><td>
    <input type="text" class="digits_fld" name="single[start_size][]" value="100">
    </td>
    </tr>
    
    <tr>
    <td>
    Start opacity in
    </td><td>
    <input type="text" class="digits_fld" name="single[start_opacityin][]" value="100">
    </td>
    <td>
    Start opacity out
    </td><td>
    <input type="text" class="digits_fld" name="single[start_opacityout][]" value="100">
    </td>
    <td>
    Start position x in
    </td><td>
    <input type="text" class="digits_fld" name="single[start_posxin][]" value="1">
    </td>
    </tr>

    <tr>
    <td>
    Start position x out
    </td><td>
    <input type="text" class="digits_fld" name="single[start_posxout][]" value="1">
    </td>
    <td>
    Start position y in
    </td><td>
    <input type="text" class="digits_fld" name="single[start_posyin][]" value="1">
    </td>
    <td>
    Start position y out
    </td><td>
    <input type="text" class="digits_fld" name="single[start_posyout][]" value="1">
    </td>
    </tr>

    <tr>
    <td>
    Start duration
    </td><td>
    <input type="text" class="digits_fld" name="single[start_duration][]" value="1000">
    </td>
    <td>
    Start easing
    </td><td>
    <select name="single[start_easing][]">
    <?php
    $start_easing = 'swing';
    $easings = array("linear", "swing", "easeInQuad", "easeOutQuad", "easeInOutQuad", "easeInCubic", "easeOutCubic", "easeInOutCubic", "easeInQuart", "easeOutQuart", "easeInOutQuart", "easeInQuint", "easeOutQuint", "easeInOutQuint", "easeInExpo", "easeOutExpo", "easeInOutExpo", "easeInSine", "easeOutSine", "easeInOutSine", "easeInCirc", "easeOutCirc", "easeInOutCirc", "easeInElastic", "easeOutElastic", "easeInOutElastic", "easeInBack", "easeOutBack", "easeInOutBack", "easeInBounce", "easeOutBounce", "easeInOutBounce");
    foreach ($easings as $ease)
      {
        if ($ease == $start_easing)
          echo "<option value='$ease' selected='selected'>$ease</option>";
          else
          echo "<option value='$ease'>$ease</option>";
      }
    ?>
    </select>
    </td>
    <td>
    Start Method
    </td><td>
    <select name="single[start_method][]">
    <?php
    $start_method = 'left_right';
    $methods_start = array('left_bottom', 'left_top', 'left_right', 'right_bottom', 'right_top', 'right_left', 'top_bottom', 'top_right', 'top_left', 'bottom_top', 'bottom_right', 'bottom_left', 'from');
    foreach ($methods_start as $mt)
      {
        if ($mt == $start_method)
          echo "<option value='$mt' selected='selected'>$mt</option>";
          else
          echo "<option value='$mt'>$mt</option>";
      }

    ?>
    </select>
    </td>
    </tr>

    <tr>
    <td>
    Start rotation in
    </td><td>
    <input type="text" class="digits_fld" name="single[start_rotation][]" value="0">
    </td>
    <td>
    Start rotation out
    </td><td>
    <input type="text" class="digits_fld" name="single[start_rotation_out][]" value="0">
    </td>
    <td>
    Start rotation origin
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_rotation_origin][]" value="50% 50%">
    </td>
    </tr>
    <tr>
    <td>
    Perspective
    </td>
    <td>
    <input type="text" class="digits_fld" name="single[perspective][]" value="1000">
    </td>
    <td>
    Start rotation 3d in
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_rotation3d][]" value="0,0,0,0deg">
    </td>
    <td>
    Start rotation 3d out
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_rotation3d_out][]" value="0,0,0,0deg">
    </td>
    </tr>
    <tr>
    <td>
    Start scale 3d in
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_scale3d][]" value="1,1,1">
    </td>
    <td>
    Start scale 3d out
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_scale3d_out][]" value="1,1,1">
    </td>
    <td>
    Start translate 3d in
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_translate3d][]" value="0,0,0">
    </td>
    <tr>
    <td>
    Start translate 3d out
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_translate3d_out][]" value="0,0,0">
    </td>
    <td>
    Start transform3d origin
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_transform3d_origin][]" value="50% 50% 50">
    </td>
    <td>
    
    </td>
    <td>
    
    </td>
    </tr>
    
    <tr>
    <td colspan="6">
    <button name="add_move_point" type="button" class="add_move_point hdn" id="add_move_point_[MOVESID]">Add move point</button>
    <button name="add_delay_point" type="button" class="add_delay_point hdn" id="add_delay_point_[MOVESID]">Add delay point</button>
      <div class="points_area" id='points_area_[MOVESID]'>
      <div class="points">
      
      </div>      
      <div class='mplast' id='mplast_[MOVESID]'>0</div>
      </div>
    
    </td>
    </tr>

    <tr>
    <td colspan="2">
    Use Method of manipulation
    </td>
    <td colspan="2">
    <select name="single[finish_transform_method][]">
<?php

  foreach ($transform_methods as $tm_key=>$tm)
    {
 ?>
    <option value="<?php echo $tm_key; ?>" <?php if (1 == $tm_key)echo 'selected="selected"'; ?>><?php echo $tm; ?></option>
    <?php
    }
    ?>
    </select>
    </td>
    </tr>
    
    <tr>
    <td>
    Finish size
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_size][]" value="100">
    </td>
    <td>
    Finish opacity
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_opacity][]" value="100">
    </td>
    <td>
    Finish position x in
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_posxin][]" value="1">
    </td>
    </tr>

    <tr>
    <td>
    Finish position x out
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_posxout][]" value="1">
    </td>
    <td>
    Finish position y in
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_posyin][]" value="1">
    </td>
    <td>
    Finish position y out
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_posyout][]" value="1">
    </td>
    </tr>

    <tr>
    <td>
    Finish duration
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_duration][]" value="1000">
    </td>
    <td>
    Finish easing
    </td><td>
    <select name="single[finish_easing][]">
    <?php
    $finish_easing = 'swing';
    foreach ($easings as $ease)
      {
        if ($ease == $finish_easing)
          echo "<option value='$ease' selected='selected'>$ease</option>";
          else
          echo "<option value='$ease'>$ease</option>";
      }
    ?>
    </select>
    </td>
    <td>
    Finish Method
    </td><td>
    <select name="single[finish_method][]">
    <?php
    $finish_method = 'left_right';
    $methods_finish = array('left_bottom', 'left_top', 'left_right', 'right_bottom', 'right_top', 'right_left', 'top_bottom', 'top_right', 'top_left', 'bottom_top', 'bottom_right', 'bottom_left', 'to');
    foreach ($methods_finish as $mt)
      {
        if ($mt == $finish_method)
          echo "<option value='$mt' selected='selected'>$mt</option>";
          else
          echo "<option value='$mt'>$mt</option>";
      }
    ?>
    </select>
    </td>
    </tr>

    <tr>
    <td>
    Finish rotation
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_rotation][]" value="0">
    </td>
    <td>
    Finish rotation origin
    </td><td>
    <input type="text" class="notempty_fld" name="single[finish_rotation_origin][]" value="50% 50%">
    </td>
    <td>
    Finish rotation 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[finish_rotation3d][]" value="0,0,0,0deg">
    </td>
    </tr>
    <tr>
    <td>
    Finish scale 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[finish_scale3d][]" value="1,1,1">
    </td>
    <td>
    Finish translate 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[finish_translate3d][]" value="0,0,0">
    </td>
    
    <td>
    Finish transform 3d origin
    </td><td>
    <input type="text" class="notempty_fld" name="single[finish_transform3d_origin][]" value="50% 50% 50">
    </td>
    </tr>

    <tr>
    <td>
    Width
    </td><td>
    <input type="text" class="digits_fld" name="single[width][]" value="0">
    </td>
    <td>
    Height
    </td><td>
    <input type="text" class="digits_fld" name="single[height][]" value="0">
    </td>
    <td>
    Font size
    </td><td>
    <input type="text" class="digits_fld" name="single[font-size][]" value="0">
    </td>
    </tr>
    <tr><td colspan="6">
      <button name="remove_accordion" class="hdn" id="remove_accordion_[MOVESID]" style="float:right;">Remove</button>
    </td></tr>

    </table>
    <input type="hidden" name="single[moveid][]" value='[MOVESID]'>
    </div>
  </div>
</div>

<div class="move_point_hidden_form">
          <div class="mpt_group" id="mpt_group_[MOVEPOINT]">
          <h3>Point #[MPNUM]</h3>
          <div class="mpt_inner_group">

<table>
    <tr>
    <td colspan="2">
    Use Method of manipulation
    </td>
    <td colspan="2">
    <select name="single[move_point][transform_method][]">
<?php

  foreach ($transform_methods as $tm_key=>$tm)
    {
 ?>
    <option value="<?php echo $tm_key; ?>" <?php if (1 == $tm_key)echo 'selected="selected"'; ?>><?php echo $tm; ?></option>
    <?php
    }
    ?>
    </select>
    </td>
    </tr>

<tr>
<td>
Size
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][size][]" value='100'>  
</td>

<td>
Opacity
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][opacity][]" value='100'>  
</td>

<td>
Position x
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][posx][]" value='1'>  
</td>

</tr>

<tr>

<td>
Position y
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][posy][]" value='1'>  
</td>

<td>
Position x out
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][posxout][]" value='1'>  
</td>

<td>
Position y out
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][posyout][]" value='1'>  
</td>

</tr>

<tr>

<td>
Duration
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][duration][]" value='1000'>  
</td>

<td>
Easing
</td>
<td>
    <select name="single[move_point][easing][]">
    <?php
    $init_easing = 'swing';
    foreach ($easings as $ease)
      {
        if ($ease == $init_easing)
          echo "<option value='$ease' selected='selected'>$ease</option>";
          else
          echo "<option value='$ease'>$ease</option>";
      }
    ?>
    </select>
</td>

<td>
Method
</td>
<td>
    <input type="text" class="notempty_fld" name="single[move_point][method][]" value='move_point'>  
</td>

</tr>

<tr>

<td>
Rotation
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][rotation][]" value='0'>  
</td>

<td>
Rotation origin
</td>
<td>
    <input type="text" class="notempty_fld" name="single[move_point][rotation_origin][]" value='50% 50%'>  
</td>
    <td>
    Rotation 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[move_point][rotation3d][]" value="0,0,0,0deg">
    </td>
</tr>
<tr>
    <td>
    Scale 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[move_point][scale3d][]" value="1,1,1">
    </td>
    <td>
    Translate 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[move_point][translate3d][]" value="0,0,0">
    </td>
    <td>
    Transform 3d origin
    </td><td>
    <input type="text" class="notempty_fld" name="single[move_point][transform3d_origin][]" value="50% 50% 50">
    </td>
</tr>
<tr>
<td>
Action
</td>
<td>
    <button name="remove_point" class="remove_point hdn" id="remove_point_[MOVEPOINT]" style="float:right;">Remove</button>
    <input type="hidden" name="single[move_point][id][]" value='[MOVEPOINT]'>  
</td>


</tr>
</table>
</div>
</div>

</div>


<div class="delay_point_hidden_form">
          <div class="mpt_group" id="mpt_group_[MOVEPOINT]">
          <h3>Point #[MPNUM]</h3>
          <div class="mpt_inner_group">

<table>
<tr>
<td>
Duration
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][duration][]" value='1000'>  
</td>

<td>
Method
</td>
<td>
    <input type="text" class="notempty_fld" name="single[move_point][method][]" value='delay_point'>  
</td>

<td>
Action
</td>
<td>
    <button name="remove_point" class="remove_point hdn" id="remove_point_[MOVEPOINT]" style="float:right;">Remove</button>
    <input type="hidden" name="single[move_point][id][]" value='[MOVEPOINT]'>  
    
    <input type="hidden" class="digits_fld" name="single[move_point][size][]" value='1'>  
    <input type="hidden" class="digits_fld" name="single[move_point][opacity][]" value='1'>  
    <input type="hidden" class="digits_fld" name="single[move_point][posx][]" value='1'>  
    <input type="hidden" class="digits_fld" name="single[move_point][posy][]" value='1'>  
    <input type="hidden" class="digits_fld" name="single[move_point][posxout][]" value='1'>  
    <input type="hidden" class="digits_fld" name="single[move_point][posyout][]" value='1'>  
    <input type="hidden" name="single[move_point][easing][]" value='swing'> 
    <input type="hidden" class="digits_fld" name="single[move_point][rotation][]" value='0'>  
    <input type="hidden" class="notempty_fld" name="single[move_point][rotation_origin][]" value='0'>  
    <input type="hidden" class="digits_fld" name="single[move_point][transform_method][]" value='1'>  

    <input type="hidden" class="notempty_fld" name="single[move_point][rotation3d][]" value='0,0,0,0deg'>  
    <input type="hidden" class="notempty_fld" name="single[move_point][scale3d][]" value='1,1,1'>  
    <input type="hidden" class="notempty_fld" name="single[move_point][translate3d][]" value='0,0,0'>  
    <input type="hidden" class="notempty_fld" name="single[move_point][transform3d_origin][]" value='50% 50% 50'>  

</td>

</tr>
</table>
</div>
</div>

</div>

<button id="save_containers_positions">Save Containers Positions</button>
  </div>
<!--
  </div>
  </div>
-->
<!-- ********************************************* END Tab Page 2 ****************************************************** -->
