
<div class="panel panel-primary">
<div class="panel-heading">

<h3 class="panel-title">Background main info</h3>

</div>
<div class="panel-body">

  <div>
  <form method="POST" class="main_info_frm" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=0&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&amp;updated=true">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_main_info');
    }
  ?>
  <input type="hidden" name="pid" value="<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
  
  
  <div class="leftbord">
  <table>
  <tr>
  <td>
  Width
  </td>
  <td>
  <input name="width" class="digits_fld" size="10" value="<?php if (isset($main_info)&&(isset($main_info[0]->width)))echo $main_info[0]->width; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Height
  </td>
  <td>
  <input name="height" class="digits_fld" size="10" value="<?php if (isset($main_info)&&(isset($main_info[0]->height)))echo $main_info[0]->height; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Horizontal align
  </td>
  <td>
  <select name="halign">
  <?php
  $src = array(0 => "left", 1 => "center", 2 => "right");
  foreach ($src as $key=>$sr)
    {
    if (isset($main_info)&&isset($main_info[0]->halign)&&($main_info[0]->halign == $key))
      echo "<option value='".$key."' selected='selected'>".$sr."</option>";
      else
      echo "<option value='".$key."'>".$sr."</option>";
    }
  ?>
  </select>
  </td>
  </tr>
  <tr>
  <td>
  Vertical align
  </td>
  <td>
  <select name="valign">
  <?php
  $src = array(0 => "top", 1 => "middle", 2 => "bottom");
  foreach ($src as $key=>$sr)
    {
    if (isset($main_info)&&isset($main_info[0]->valign)&&($main_info[0]->valign == $key))
      echo "<option value='".$key."' selected>".$sr."</option>";
      else
      echo "<option value='".$key."'>".$sr."</option>";
    }
  ?>
  </select>
  </td>
  </tr>
  <tr>
  <td>
  Effect
  </td>
  <td>
  <select name="effect">
  <?php $main_effects = array("default", "slideHoriz", "slideVert", "slideBlink", "slideSize", "slideSizeO", "slideSizeM",
  "slideSequenceHorizOpacity", "slideSequenceHorizRotateY", "slideSequenceHorizDiagonal", "slideSequenceVertOpacity", 
  'slidePrecipitation', 'slideAttractionHoriz', 'slideSequenceDiagonalSize', 'slideClotAndSmoke', 'slideCollectWave', 
  'slideSwirlCorner', 'slideWaveUpDown', 'slideEasyFolding'/*, 'slideTry'*/); ?>

    <?php if ((isset($main_info))&&(isset($main_info[0]->effect))) {
  foreach ($main_effects as $me)
  {
   ?>
    <option value="<?php echo $me; ?>"><?php echo $me; ?></option>
    <?php } } ?>
  </select>
  <button name="apply_effect_name">apply effect</button>
  <div class="applied_effects">
  <?php if ((isset($main_info))&&(isset($main_info[0]->effect))) {
  $applied_effects = explode("***", $main_info[0]->effect);
  foreach ($applied_effects as $ae)
  {
   ?>
  <?php if (in_array($ae, $main_effects)) { ?>
    <div class='effect_element' style='line-height:30px;'><img src='<?php echo plugins_url("../images/close.png", __FILE__); ?>' class='close_effect_elem' style='cursor:pointer;'>&nbsp;&nbsp;&nbsp;<?php echo $ae; ?><input type='hidden' name='effects_names[]' value='<?php echo $ae; ?>'></div>
    <?php } 
    }
  } ?>

  </td>
  </tr>
  
  <tr>
  <td>
  Apply Styles
  </td>
  <td>
  <textarea name="apply_classes" style='width:400px;height:200px;'>
    <?php if (isset($main_info)&&(isset($main_info[0]->apply_classes)))echo stripcslashes($main_info[0]->apply_classes); ?>
  </textarea>
  </td>
  </tr>

  </table>
  </div>
  <div class="leftbord">
    <table>
  <tr>
  <td>
  Project Name
  </td>
  <td>
  <input name="name" class="notempty_fld" size="10" value="<?php if (isset($main_info)&&(isset($main_info[0]->name)))echo $main_info[0]->name; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Active Area Width
  </td>
  <td>
  <input name="activewidth" class="digits_fld" size="10" value="<?php if (isset($main_info)&&(isset($main_info[0]->activewidth)))echo $main_info[0]->activewidth; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Active Area Height
  </td>
  <td>
  <input name="activeheight" class="digits_fld" size="10" value="<?php if (isset($main_info)&&(isset($main_info[0]->activeheight)))echo $main_info[0]->activeheight; ?>">
  </td>
  </tr>

  <tr>
  <td>
  Active Area Offset Left
  </td>
  <td>
  <input name="activeoffsetleft" class="digits_fld" size="10" value="<?php if (isset($main_info)&&(isset($main_info[0]->activeoffsetleft)))echo $main_info[0]->activeoffsetleft; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Active Area Offset Top
  </td>
  <td>
  <input name="activeoffsettop" class="digits_fld" size="10" value="<?php if (isset($main_info)&&(isset($main_info[0]->activeoffsettop)))echo $main_info[0]->activeoffsettop; ?>">
  </td>
  </tr>

  <tr>
  <td>
  Duration
  </td>
  <td>
  <input name="duration" class="digits_fld" size="10" value="<?php if (isset($main_info)&&(isset($main_info[0]->duration)))echo $main_info[0]->duration; ?>">
  </td>
  </tr>

  <tr>
  <td>
  Effect's duration
  </td>
  <td>
  <input name="duration_effect" class="digits_fld" size="10" value="<?php if (isset($main_info)&&(isset($main_info[0]->duration_effect)))echo $main_info[0]->duration_effect; ?>">
  </td>
  </tr>

  <tr>
  <td>
  Direction
  </td>
  <td>
  <select name="effect_direction">
  <?php $directions = array('forward', 'backward');
  if ((isset($main_info))&&(isset($main_info[0]->effect_direction))) { 
  foreach ($directions as $direct)
    {
  ?>
  <?php if ($main_info[0]->effect_direction == $direct) { ?>
    <option value="<?php echo $direct; ?>" selected="selected"><?php echo $direct; ?></option>
    <?php } else { ?>
    <option value="<?php echo $direct; ?>"><?php echo $direct; ?></option>
    <?php } } } ?>
  </select>
  </td>
  </tr>

  <tr>
  <td>
  Full Screen
  </td>
  <td>
  <input type="checkbox" name="fullscreen" size="10" value="1" <?php if (isset($main_info)&&(isset($main_info[0]->fullscreen))&&($main_info[0]->fullscreen == 1))echo " checked='checked'"; ?>>
  </td>
  </tr>

  <tr>
  <td>
  Full Width
  </td>
  <td>
  <input type="checkbox" name="fullwidth" size="10" value="1" <?php if (isset($main_info)&&(isset($main_info[0]->fullwidth))&&($main_info[0]->fullwidth == 1))echo " checked='checked'"; ?>>
  </td>
  </tr>

  <tr>
  <td>
  Slide Processing Show
  </td>
  <td>
  <input type="checkbox" name="slide_processing" size="10" value="1" <?php if (isset($main_info)&&(isset($main_info[0]->slide_processing))&&($main_info[0]->slide_processing == 1))echo " checked='checked'"; ?>>
  </td>
  </tr>

  <tr>
  <td colspan="2" align="right">
  <input type="submit" value=" Save main info " name="main_info_save_btn" />
  </td>
  </tr>
  </table>
  </div>

  </form>
  </div>
<div class="clear_line"></div>

</div>
</div>
