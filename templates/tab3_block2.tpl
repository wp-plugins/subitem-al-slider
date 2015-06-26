    <div id="one_image_info">
<div class="chk">
  <div class="chk_in">
    <input type="checkbox" name="image_chk_now[]" value="[IMAGEIDONLY]">
  </div>
</div>
<div class="mn_image">

  <h3>Image #[NUM] (ID:[IMAGEIDONLY])</h3>
    <div class="image_data">
    
<form method="POST" id="img_frm_[IMAGEIDONLY]" class="img_frm" action="<?php if (strpos("$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]", 'active=2') != false)echo 'http' . (isset($_SERVER['HTTPS']) ? 's' : '') . '://' . "$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]"; else echo $_SERVER['PHP_SELF']."?page=sial_slider_show&active=2&pid=".((isset($_GET['pid'])&&(!empty($_GET['pid']))) ? $_GET['pid'] : $proj_id)."&amp;updated=true"; ?>">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_image');
    }
  ?>

<input type="hidden" name="pid" value="<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
<div class="imageid">[IMAGEID]</div>

      <table class="one_image_info_table">
  <tr>
  <td>
  Name
  </td>
  <td>
  <input name="name" size="50" value="">
  </td>
  </tr>
  <tr>
  <td>
  URL
  </td>
  <td>
  <input name="url" size="50" value="">
  </td>
  </tr>
    <tr>
  <td>
  Image
  </td>
  <td>
  <input name="image" class="notempty_fld" size="50" value="[IMAGE]">
  </td>
  </tr>
  <tr>
  <td>
  Width
  </td>
  <td>
  <input name="width" class="digits_fld" size="10" value="[IMAGE_WIDTH]">
  </td>
  </tr>
  <tr>
  <td>
  Height
  </td>
  <td>
  <input name="height" class="digits_fld" size="10" value="[IMAGE_HEIGHT]">
  </td>
  </tr>
  <tr>
  <td>
  Offset Left
  </td>
  <td>
  <input name="offsetleft" class="digits_fld" size="10" value="0">
  </td>
  </tr>
  <tr>
  <td>
  Offset Top
  </td>
  <td>
  <input name="offsettop" class="digits_fld" size="10" value="0">
  </td>
  </tr>
  <tr>
  <td>
  Group
  </td>
  <td>
  [GROUP]
  </td>
  </tr>
  <tr>
  <td>
  Group position
  </td>
  <td>
  <input name="grouppos" class="digits_fld" size="10" value="[GROUPPOS]">
  </td>
  </tr>

  <tr>
  <td>
  Classes List
  </td>
  <td>
  <input name="classes_list" class="" size="60" value="">
  </td>
  </tr>

  
  </table>
      <input class="hdn" type="submit" value=" Save this image " name="image_save_btn">
    <input class="hdn" type="submit" value=" Delete this image " name="image_del_btn">

  </form>
</div>
</div>
<div class="img_sample">[IMAGE_FILE]</div>
  <div class="clear_line"></div>
  
  </div>
  <br>
<form id="mass_action_images_form" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=2&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&amp;updated=true">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_image_delete_mass');
    }
  ?>
<div class="hidden_chk_1">
  
</div>
<select id="image_mass_action" name="image_mass_action">
  <option value="0">None</option>
  <option value="1">Delete</option>
</select>
<input type="submit" id="image_mass_effect" name="image_mass_execution_btn" value="Execute">
</form>
