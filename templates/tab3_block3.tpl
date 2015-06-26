  <h2>Text Items</h2>
  <div class="text_items">
<?php 
$ln = -1;
if (isset($text_info)&&(!empty($text_info)))
  foreach ($text_info as $key=>$text)
    {
    $ln = $key;
    ?>
<div class="chk">
  <div class="chk_in">
    <input type="checkbox" name="text_chk_now[]" value="<?php echo $text->id; ?>">
  </div>
</div>
<div class="mn_text">
  <h3>Text #<?php echo $key+1; ?> (ID:<?php echo $text->id; ?>)</h3>
    <div class="text_data">
    
  <form method="POST" id="txt_frm_<?php echo $text->id; ?>" class="txt_frm" action="<?php if (strpos("$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]", 'active=2') != false)echo 'http' . (isset($_SERVER['HTTPS']) ? 's' : '') . '://' . "$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]"; else echo $_SERVER['PHP_SELF']."?page=sial_slider_show&active=2&pid=".((isset($_GET['pid'])&&(!empty($_GET['pid']))) ? $_GET['pid'] : $proj_id)."&amp;updated=true"; ?>">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_text');
    }
  ?>

<input type="hidden" name="pid" value="<?php echo $text->id_main; ?>">
<input type="hidden" name="textid" value="<?php echo $text->id; ?>">
<input type="hidden" name="textstatus" value="old">
    
      <table class="one_text_info_table">
  <tr>
  <td>
  Name
  </td>
  <td>
  <input name="name" size="50" value="<?php echo $text->name; ?>">
  </td>
  </tr>
  <tr>
  <td>
  URL
  </td>
  <td>
  <input name="url" size="50" value="<?php echo $text->url; ?>">
  </td>
  </tr>
    <tr>
  <td>
  Text
  </td>
  <td>
  <input name="text" class="notempty_fld" size="50" value="<?php echo htmlspecialchars(stripslashes($text->text)); ?>">
  </td>
  </tr>
  <tr>
  <td>
  Width
  </td>
  <td>
  <input name="width" class="digits_fld" size="10" value="<?php echo $text->width; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Height
  </td>
  <td>
  <input name="height" class="digits_fld" size="10" value="<?php echo $text->height; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Offset Left
  </td>
  <td>
  <input name="offsetleft" class="digits_fld" size="10" value="<?php echo $text->offsetleft; ?>">
  </td>
  </tr>
  <tr>
  <td>
  Offset Top
  </td>
  <td>
  <input name="offsettop" class="digits_fld" size="10" value="<?php echo $text->offsettop; ?>">
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
      if ($gr->id == $text->groupid)
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
  <input name="grouppos" class="digits_fld" size="10" value="<?php echo $text->grouppos; ?>">
  </td>
  </tr>

  <tr>
  <td>
  Font size
  </td>
  <td>
  <input name="size" class="digits_fld" size="10" value="<?php echo $text->size; ?>">
  </td>
  </tr>

  <tr>
  <td>
  Font color
  </td>
  <td>
  <input type="text" name="color" size="10" value="<?php echo $text->color; ?>">
  </td>
  </tr>

  <tr>
  <td>
  Background color
  </td>
  <td>
  <input type="text" name="bgcolor" size="10" value="<?php echo $text->bgcolor; ?>">
  </td>
  </tr>

  <tr>
  <td>
  Style
  </td>
  <td>
  <input type="text" name="style" class="" size="60" value="<?php echo $text->style; ?>">
  </td>
  </tr>

  <tr>
  <td>
  Classes List
  </td>
  <td>
  <input name="classes_list" class="" size="60" value="<?php echo $text->classes_list; ?>">
  </td>
  </tr>

  </table>
      <input type="submit" value=" Save this text " name="text_save_btn">
    <input type="submit" value=" Delete this text " name="text_del_btn">
  </form>
</div>
</div>
<div class="clear_line"></div>
<?php
    }
?>

<div id="last_number_text"><?php echo $ln+1; ?></div>

  </div>
<?php
    echo $pagination_txt;
?>
