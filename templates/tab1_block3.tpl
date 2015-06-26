<div id="one_bg_info">

<div class="chk">
  <div class="chk_in">
    <input type="checkbox" name="chk_now[]" value="[BGIDONLY]">
  </div>
</div>
<div class="mn_bg">

  <h3>Background #[NUM] (ID:[BGIDONLY])</h3>
    <div class="bg_data">
    
  <form method="POST" id="bg_info_frm_[BGIDONLY]" class="bg_info_frm" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=0&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&amp;updated=true">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_bg_image');
    }
  ?>

<input type="hidden" name="pid" value="<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
<input type="hidden" name="bgstatus" value="old">
<div class="bgid">[BGID]</div>
      <table class="one_bg_info_table">
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
  Description
  </td>
  <td>
  <textarea name="desc" cols="45" rows="4"></textarea>
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
  Background image
  </td>
  <td>
  <input name="bgimg" class="notempty_fld" size="50" value="[IMAGE]">
  </td>
  </tr>
  </table>
      <input type="submit" class="hdn" value=" Save this background " name="bg_save_btn">
    <input type="submit" class="hdn" value=" Delete this background " name="bg_del_btn">
  </form>
</div>
</div>
<div class="img_sample">[IMAGE_FILE]</div>
<div class="clear_line"></div>

    </div>
    
<form id="mass_action_form" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=0&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&amp;updated=true">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_bg_image_delete_mass');
    }
  ?>
<div class="hidden_chk">
  
</div>
<select id="mass_action" name="mass_action">
  <option value="0">None</option>
  <option value="1">Delete</option>
</select>
<input type="submit" id="mass_effect" name="mass_execution_btn" value="Execute">
</form>

  </div>
