<p style="float:right;">* Background Name and Image Item name using as alt attributes in front slider.</p><br>
  <h2>Background images settings</h2>
  <div class="output_bg_sets">
<?php 
$ln = -1;
if (isset($bg_info)&&(!empty($bg_info)))
  foreach ($bg_info as $key=>$bg)
    {
    $ln = $key;
    ?>
<div class="chk">
  <div class="chk_in">
    <input type="checkbox" name="chk_now[]" value="<?php echo $bg->id; ?>">
  </div>
</div>
<div class="mn_bg">
  <h3>Background #<?php echo $key+1; ?> (ID:<?php echo $bg->id; ?>)</h3>
    <div class="bg_data">
    
  <form method="POST" id="bg_info_frm_<?php echo $bg->id; ?>" class="bg_info_frm" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=0&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&amp;updated=true">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_bg_image');
    }
  ?>

<input type="hidden" name="pid" value="<?php echo $bg->id_main; ?>">
<input type="hidden" name="bgid" value="<?php echo $bg->id; ?>">
<input type="hidden" name="bgstatus" value="old">
    
      <table class="one_bg_info_table">
  <tr>
  <td>
  Name
  </td>
  <td>
  <input name="name" size="50" value="<?php echo $bg->name; ?>">
  </td>
  </tr>
    <tr>
  <td>
  Description
  </td>
  <td>
  <textarea name="desc" cols="45" rows="4"><?php echo $bg->descr; ?></textarea>
  </td>
  </tr>
  <tr>
  <td>
  URL
  </td>
  <td>
  <input name="url" size="50" value="<?php echo $bg->url; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Background image
  </td>
  <td>
  <input name="bgimg" class="notempty_fld" size="50" value="<?php echo $bg->image; ?>">
  </td>
  </tr>
  </table>
    <input type="submit" value=" Save this background " name="bg_save_btn">
    <input type="submit" value=" Delete this background " name="bg_del_btn">
  </form>
</div>
</div>
<div class="img_sample"><img src="<?php echo $bg->image; ?>" width="200"></div>
<div class="clear_line"></div>
<?php
    }
?>

<div id="last_number"><?php echo $ln+1; ?></div>
  </div>
