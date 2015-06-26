<div class="container_area">

<?php 
if ((isset($containers_info))&&(!empty($containers_info))&&(is_array($containers_info))) { 
  $ctn = 0;
?>
<?php foreach ($containers_info as $key=>$container) { 
  $ctn++;
    $container_num = $ctn;
?>
<div class="container_box_<?php echo $container->id; ?>">
<div id="container_frm_<?php echo $container->id; ?>_errors" class="container_frm__errors">

</div>

<div class="chk2">
  <div class="chk_in">
    <!--<input type="checkbox" name="container_chk_now[]" value="<?php echo $container->id; ?>">-->
  </div>
</div>
<div class="mn_container">
  <h3>Container #<?php echo ($container_num); ?></h3>
    <div class="container_data">

<form method="POST" id="container_frm_<?php echo $container->id; ?>" class="container_frm" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=1&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&amp;updated=true">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_container');
    }
  ?>

<?php 
foreach ($bg_info as $bgin)
  {
  if ($bgin->id == $container->id_bg_image)
    echo "<img src='".$bgin->image."' style='width:200px;'>";
  }
 ?>
<br>
<?php $cur_nonce = wp_create_nonce( 'slide_url' ); ?>
<a href="<?php echo admin_url(); ?>admin.php?subitem_al_slide&<?php echo $cur_nonce; ?>&<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&<?php echo $container->id; ?>" target="_blank" style='float:right;font-weight:bold;'>Slide Results >>></a>
<br>
<a href="<?php echo admin_url(); ?>admin.php?page=sial_slide&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&container=<?php echo $container->id; ?>&num=<?php echo $container_num;  ?>" target="_blank" style='float:right;font-weight:bold;'>Slide Setup >>></a>

<input type="hidden" name="pid" value="<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
<input type="hidden" name="num" value="<?php echo $ctn; ?>">
<input type="hidden" name="containerid" value="<?php echo $container->id; ?>">
<input type="hidden" name="item_type" value="1"><!-- "1"-image -->



<input type="hidden" name="num_items_<?php echo $container->id; ?>" value="<?php $num_items++; echo $num_items; ?>">
<!--      <input type="submit" value=" Save this container " name="container_save_btn">-->
    <input type="submit" value=" Delete this container " name="container_del_btn">

  </form>
</div>
</div>

<div class="bottom_up_down">
<div class="up_btn"><img src='<?php echo plugins_url("../images/up.png", __FILE__); ?>'></div>
<div class="down_btn"><img src='<?php echo plugins_url("../images/down.png", __FILE__); ?>'></div>
</div>
<div class="clear_line"></div>
</div>


  

<?php } ?>
<?php } ?>
</div>

<div id="last_number_container"><?php if (isset($container_num)) echo $container_num; else echo 0; ?></div>

<div class="container_hidden_num"></div>
