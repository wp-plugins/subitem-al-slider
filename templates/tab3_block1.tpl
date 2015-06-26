  <h2>Image Items</h2>
  <div class="image_items">
<?php 
$ln = -1;
if (isset($image_info)&&(!empty($image_info)))
  foreach ($image_info as $key=>$image)
    {
    $ln = $key;
    ?>
<div class="chk">
  <div class="chk_in">
    <input type="checkbox" name="image_chk_now[]" value="<?php echo $image->id; ?>">
  </div>
</div>
<div class="mn_image">
  <h3>Image #<?php echo $key+1; ?> (ID:<?php echo $image->id; ?>)</h3>
    <div class="image_data">
    
  <form method="POST" id="img_frm_<?php echo $image->id; ?>" class="img_frm" action="<?php if (strpos("$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]", 'active=2') != false)echo 'http' . (isset($_SERVER['HTTPS']) ? 's' : '') . '://' . "$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]"; else echo $_SERVER['PHP_SELF']."?page=sial_slider_show&active=2&pid=".((isset($_GET['pid'])&&(!empty($_GET['pid']))) ? $_GET['pid'] : $proj_id)."&amp;updated=true"; ?>">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_image');
    }
  ?>

<input type="hidden" name="pid" value="<?php echo $image->id_main; ?>">
<input type="hidden" name="imageid" value="<?php echo $image->id; ?>">
<input type="hidden" name="imagestatus" value="old">
    
      <table class="one_image_info_table">
  <tr>
  <td>
  Name
  </td>
  <td>
  <input name="name" size="50" value="<?php echo $image->name; ?>">
  </td>
  </tr>
  <tr>
  <td>
  URL
  </td>
  <td>
  <input name="url" size="50" value="<?php echo $image->url; ?>">
  </td>
  </tr>
    <tr>
  <td>
  Image
  </td>
  <td>
  <input name="image" class="notempty_fld" size="50" value="<?php echo $image->image; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Width
  </td>
  <td>
  <input name="width" class="digits_fld" size="10" value="<?php echo $image->width; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Height
  </td>
  <td>
  <input name="height" class="digits_fld" size="10" value="<?php echo $image->height; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Offset Left
  </td>
  <td>
  <input name="offsetleft" class="digits_fld" size="10" value="<?php echo $image->offsetleft; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Offset Top
  </td>
  <td>
  <input name="offsettop" class="digits_fld" size="10" value="<?php echo $image->offsettop; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Group
  </td>
  <td>
  <select name="group">
  <?php
  foreach ($group_info as $gr)
    {
      if ($gr->id == $image->groupid)
        echo "<option value='".$gr->id."' selected='selected'>".$gr->name."</option>";
        else
        echo "<option value='".$gr->id."'>".$gr->name."</option>";
    }
  ?>
  </select>
  </td>
  </tr>
  <tr>
  <td>
  Group position
  </td>
  <td>
  <input name="grouppos" class="digits_fld" size="10" value="<?php echo $image->grouppos; ?>">
  </td>
  </tr>

  <tr>
  <td>
  Classes List
  </td>
  <td>
  <input name="classes_list" class="" size="60" value="<?php echo $image->classes_list; ?>">
  </td>
  </tr>

  </table>
      <input type="submit" value=" Save this image " name="image_save_btn">
    <input type="submit" value=" Delete this image " name="image_del_btn">
  </form>
</div>
</div>
<div class="img_sample"><img src="<?php echo $image->image; ?>" width="<?php echo ($image->width<200) ? $image->width : 200; ?>"></div>
<div class="clear_line"></div>
<?php
    }
?>

<div id="last_number_image"><?php echo $ln+1; ?></div>

  </div>
<?php
    echo $pagination_img;
?>
