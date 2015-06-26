<div id="one_text_info">
<div class="chk">
  <div class="chk_in">
    <input type="checkbox" name="text_chk_now[]" value="[TXTIDONLY]">
  </div>
</div>
<div class="mn_text">

  <h3>Text #[NUM] (ID:[TXTIDONLY])</h3>
    <div class="text_data">
    
<form method="POST" id="txt_frm_[TXTIDONLY]" class="txt_frm" action="<?php if (strpos("$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]", 'active=2') != false)echo 'http' . (isset($_SERVER['HTTPS']) ? 's' : '') . '://' . "$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]"; else echo $_SERVER['PHP_SELF']."?page=sial_slider_show&active=2&pid=".((isset($_GET['pid'])&&(!empty($_GET['pid']))) ? $_GET['pid'] : $proj_id)."&amp;updated=true"; ?>">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_text');
    }
  ?>

<input type="hidden" name="pid" value="<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
<div class="textid">[TXTID]</div>

      <table class="one_text_info_table">
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
  Text
  </td>
  <td>
  <input name="text" class="notempty_fld" size="50" value="[TEXT]">
  </td>
  </tr>
  <tr>
  <td>
  Width
  </td>
  <td>
  <input name="width" class="digits_fld" size="10" value="0">
  </td>
  </tr>
  <tr>
  <td>
  Height
  </td>
  <td>
  <input name="height" class="digits_fld" size="10" value="0">
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
  Font size
  </td>
  <td>
  <input name="size" class="digits_fld" size="10" value="10">
  </td>
  </tr>

  <tr>
  <td>
  Font color
  </td>
  <td>
  <input type="text" name="color" class="hdn_color" size="10" value="#000000">
  </td>
  </tr>

  <tr>
  <td>
  Background color
  </td>
  <td>
  <input type="text" name="bgcolor" class="hdn_color" size="10" value="#ffffff">
  </td>
  </tr>

  <tr>
  <td>
  Style
  </td>
  <td>
  <input type="text" name="style" class="" size="60" value="">
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
      <input class="hdn" type="submit" value=" Save this text " name="text_save_btn">
    <input class="hdn" type="submit" value=" Delete this text " name="text_del_btn">

  </form>
</div>
</div>
  <div class="clear_line"></div>
  
  </div>
  <br>
<form id="mass_action_texts_form" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=2&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&amp;updated=true">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_text_delete_mass');
    }
  ?>
<div class="hidden_chk_2">
  
</div>
<select id="text_mass_action" name="text_mass_action">
  <option value="0">None</option>
  <option value="1">Delete</option>
</select>
<input type="submit" id="text_mass_effect" name="text_mass_execution_btn" value="Execute">
</form>
  
  </div>
  
<!-- ********************************************* END Tab Page 3 ****************************************************** -->
  
