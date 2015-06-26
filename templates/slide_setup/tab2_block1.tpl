<div class="container_area">

<?php 
if (isset($_GET['container'])&&(isset($containers_info[$_GET['container']])))
  {
$key = $_GET['container'];
  $container = $containers_info[$key];
if ((isset($containers_info))&&(!empty($containers_info))&&(is_array($containers_info))) { 
  $ctn = $_GET['num'];
?>
<?php 
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

<button name="create_item" type="button" class="create_item" id="create_item_<?php echo $container->id; ?>">Create Item</button>
<button name="create_singleitem" type="button" class="create_singleitem" id="create_singleitem_<?php echo $container->id; ?>">Create Single Element</button>
<form method="POST" id="container_frm_<?php echo $container->id; ?>" class="container_frm" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slide&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&container=<?php echo $_GET['container']; ?>&num=<?php echo $_GET['num']; ?>&amp;updated=true">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_container');
    }
  ?>

Background:
<select name="choose_bg" class="choose_bg">
<?php foreach ($bg_info as $bg) { ?>
<?php if ($bg->id == $container->id_bg_image) { ?>
<option value="<?php echo $bg->id; ?>" selected="selected"><?php echo $bg->name."(".$bg->id.")"; ?></option>
<?php } else { ?>
<option value="<?php echo $bg->id; ?>"><?php echo $bg->name."(".$bg->id.")"; ?></option>
<?php } ?>
<?php } ?>
</select>

Effect:
<select name="choose_effect" class="choose_effect">
<?php $effects = array("default", "random", "slideHoriz", "slideVert", "slideBlink", "slideSize", "slideExplode", "slidePulsate", "slidePuff", "slideSizeO", "slideSizeM", "slideBounce", "slideShake", "slideWidth", "slideFlip", "slideFlipV", "slidePiecesV", "slidePiecesH"); ?>
<?php foreach ($effects as $effect) { ?>
<?php if ($effect == $container->effect) { ?>
<option value="<?php echo $effect; ?>" selected="selected"><?php echo $effect; ?></option>
<?php } else { ?>
<option value="<?php echo $effect; ?>"><?php echo $effect; ?></option>
<?php } ?>
<?php } ?>
</select>
Effect Direction:
<select name="effect_direction" class="effect_direction">
<?php $effect_direction = array("forward", "backward"); ?>
<?php foreach ($effect_direction as $direction) { ?>
<?php if ($direction == $container->effect_direction) { ?>
<option value="<?php echo $direction; ?>" selected="selected"><?php echo $direction; ?></option>
<?php } else { ?>
<option value="<?php echo $direction; ?>"><?php echo $direction; ?></option>
<?php } ?>
<?php } ?>
</select>    

Duration:
<input type="text" name="duration" size="10" class="duration digits_fld" value="<?php if (isset($container->duration))echo $container->duration; ?>">
<br>
Effect's duration:
<input type="text" name="duration_effect" size="10" class="duration_effect digits_fld" value="<?php if (isset($container->duration_effect_inner))echo $container->duration_effect_inner; ?>">

Left Offset:
<input type="text" name="offset_left_inner" size="10" class="digits_fld" value="<?php if (isset($container->offset_left_inner))echo $container->offset_left_inner; ?>">

Top Offset:
<input type="text" name="offset_top_inner" size="10" class="digits_fld" value="<?php if (isset($container->offset_top_inner))echo $container->offset_top_inner; ?>">

<br>
<?php $cur_nonce = wp_create_nonce( 'slide_url' ); ?>
<a href="<?php echo admin_url(); ?>admin.php?subitem_al_slide&<?php echo $cur_nonce; ?>&<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>&<?php echo $container->id; ?>" target="_blank" style='float:right;font-weight:bold;'>Slide Results >>></a>

<input type="hidden" name="pid" value="<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
<input type="hidden" name="num" value="<?php echo $ctn; ?>">
<input type="hidden" name="containerid" value="<?php echo $container->id; ?>">
<input type="hidden" name="item_type" value="1"><!-- "1"-image -->

<h4 style='font-weight:bold;'>Inner slides</h4>
<div class="container_creation_area" id="container_creation_area_<?php echo $container->id; ?>">
<?php
//var_dump($container->items);
  $num_items = 0;
if (isset($container->items)&&(!empty($container->items))&&($container->items[0]['id']))
foreach ($container->items as $key=>$item)
  {
  $num_items++;
  $str = '<select class="item_sel_box" name="item_selectbox[]">';
  foreach ($group_info as $imi)
    {
    if ($item['id_group'] == $imi->id)
    $str .= '<option value="'.$item['id'].':'.$imi->id.':'.$num_items.'" selected="selected">'.$imi->name.'(#'.$imi->id.')</option>';
      else
    $str .= '<option value="'.$item['id'].':'.$imi->id.':'.$num_items.'">'.$imi->name.'(#'.$imi->id.')</option>';
    }
    $str .= "<option value='erase:".$item['id']."'>Delete</option></select>";
    echo $str;
  }
?>
</div>
<h4 style='font-weight:bold;'>Single elements</h4>
<div class="container_creation_area_move" id="container_creation_area_move_<?php echo $container->id; ?>">
<div class="accordion">
<?php
if (isset($move_info[$container->id])&&(!empty($move_info[$container->id]))&&(is_array($move_info[$container->id])))
foreach ($move_info[$container->id] as $mvid=>$move)
  {
  ?>
   <div class="singleitem_box" id="sib_<?php if (isset($move['main']->mvid))echo $move['main']->mvid; ?>">
   <?php
   if (isset($move['main']->name)&&(!empty($move['main']->name)))
      echo "<h3>".$move['main']->name."</h3>";
      else
      echo "<h3>Single element</h3>";
   ?>
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
        if ($gr->id == $move['main']->source)
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
    Start delay
    </td><td>
    <input type="text" class="digits_fld" name="single[start_delay][]" value="<?php if (isset($move['main']->start_delay)) echo $move['main']->start_delay; ?>">
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
    <option value="<?php echo $tm_key; ?>" <?php if ($move['main']->start_transform_method == $tm_key)echo 'selected="selected"'; ?>><?php echo $tm; ?></option>
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
    <input type="text" name="single[name][]" value="<?php if (isset($move['main']->name)) echo $move['main']->name; ?>">
    </td>
    <td>
    Url
    </td><td>
    <input type="text" name="single[url][]" value="<?php if (isset($move['main']->url)) echo $move['main']->url; ?>">
    </td>
    <td>
    Start size %
    </td><td>
    <input type="text" class="digits_fld" name="single[start_size][]" value="<?php if (isset($move['main']->start_size)) echo $move['main']->start_size; ?>">
    </td>
    </tr>
    
    <tr>
    <td>
    Start opacity in %
    </td><td>
    <input type="text" class="digits_fld" name="single[start_opacityin][]" value="<?php if (isset($move['main']->start_opacityin)) echo $move['main']->start_opacityin; ?>">
    </td>
    <td>
    Start opacity out %
    </td><td>
    <input type="text" class="digits_fld" name="single[start_opacityout][]" value="<?php if (isset($move['main']->start_opacityout)) echo $move['main']->start_opacityout; ?>">
    </td>
    <td>
    Start position x in
    </td><td>
    <input type="text" class="digits_fld" name="single[start_posxin][]" value="<?php if (isset($move['main']->start_posxin)) echo $move['main']->start_posxin; ?>">
    </td>
    </tr>

    <tr>
    <td>
    Start position x out
    </td><td>
    <input type="text" class="digits_fld" name="single[start_posxout][]" value="<?php if (isset($move['main']->start_posxout)) echo $move['main']->start_posxout; ?>">
    </td>
    <td>
    Start position y in
    </td><td>
    <input type="text" class="digits_fld" name="single[start_posyin][]" value="<?php if (isset($move['main']->start_posyin)) echo $move['main']->start_posyin; ?>">
    </td>
    <td>
    Start position y out
    </td><td>
    <input type="text" class="digits_fld" name="single[start_posyout][]" value="<?php if (isset($move['main']->start_posyout)) echo $move['main']->start_posyout; ?>">
    </td>
    </tr>

    <tr>
    <td>
    Start duration
    </td><td>
    <input type="text" class="digits_fld" name="single[start_duration][]" value="<?php if (isset($move['main']->start_duration)) echo $move['main']->start_duration; ?>">
    </td>
    <td>
    Start easing
    </td><td>
    <select name="single[start_easing][]">
    <?php
    $easings = array("linear", "swing", "easeInQuad", "easeOutQuad", "easeInOutQuad", "easeInCubic", "easeOutCubic", "easeInOutCubic", "easeInQuart", "easeOutQuart", "easeInOutQuart", "easeInQuint", "easeOutQuint", "easeInOutQuint", "easeInExpo", "easeOutExpo", "easeInOutExpo", "easeInSine", "easeOutSine", "easeInOutSine", "easeInCirc", "easeOutCirc", "easeInOutCirc", "easeInElastic", "easeOutElastic", "easeInOutElastic", "easeInBack", "easeOutBack", "easeInOutBack", "easeInBounce", "easeOutBounce", "easeInOutBounce");
    foreach ($easings as $ease)
      {
        if ($ease == $move['main']->start_easing)
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
    $methods_start = array('left_bottom', 'left_top', 'left_right', 'right_bottom', 'right_top', 'right_left', 'top_bottom', 'top_right', 'top_left', 'bottom_top', 'bottom_right', 'bottom_left', 'from');
    foreach ($methods_start as $mt)
      {
        if ($mt == $move['main']->start_method)
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
    <input type="text" class="digits_fld" name="single[start_rotation][]" value="<?php if (isset($move['main']->start_rotation)) echo $move['main']->start_rotation; ?>">
    </td>
    <td>
    Start rotation out
    </td><td>
    <input type="text" class="digits_fld" name="single[start_rotation_out][]" value="<?php if (isset($move['main']->start_rotation_out)) echo $move['main']->start_rotation_out; ?>">
    </td>
    <td>
    Start rotation origin
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_rotation_origin][]" value="<?php if (isset($move['main']->start_rotation_origin)) echo $move['main']->start_rotation_origin; ?>">
    </td>
    </tr>
    <tr>
    <td>
    Perspective
    </td>
    <td>
    <input type="text" class="digits_fld" name="single[perspective][]" value="<?php if (isset($move['main']->perspective)) echo $move['main']->perspective; ?>">
    </td>
    <td>
    Start rotation 3d in
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_rotation3d][]" value="<?php if (isset($move['main']->start_rotation3d)) echo $move['main']->start_rotation3d; ?>">
    </td>
    <td>
    Start rotation 3d out
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_rotation3d_out][]" value="<?php if (isset($move['main']->start_rotation3d_out)) echo $move['main']->start_rotation3d_out; ?>">
    </td>
    </tr>
    <tr>
    <td>
    Start scale 3d in
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_scale3d][]" value="<?php if (isset($move['main']->start_scale3d)) echo $move['main']->start_scale3d; ?>">
    </td>
    <td>
    Start scale 3d out
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_scale3d_out][]" value="<?php if (isset($move['main']->start_scale3d_out)) echo $move['main']->start_scale3d_out; ?>">
    </td>
    <td>
    Start translate 3d in
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_translate3d][]" value="<?php if (isset($move['main']->start_translate3d)) echo $move['main']->start_translate3d; ?>">
    </td>
    <tr>
    <td>
    Start translate 3d out
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_translate3d_out][]" value="<?php if (isset($move['main']->start_translate3d_out)) echo $move['main']->start_translate3d_out; ?>">
    </td>
    <td>
    Start transform3d origin
    </td><td>
    <input type="text" class="notempty_fld" name="single[start_transform3d_origin][]" value="<?php if (isset($move['main']->start_transform3d_origin)) echo $move['main']->start_transform3d_origin; ?>">
    </td>
    <td>
    
    </td>
    <td>
    
    </td>
    </tr>
    
    <tr>
    <td colspan="6">
    <button name="add_move_point" type="button" class="add_move_point" id="add_move_point_<?php echo $move['main']->mvid; ?>">Add move point</button>
    <button name="add_delay_point" type="button" class="add_delay_point" id="add_delay_point_<?php echo $move['main']->mvid; ?>">Add delay point</button>
      <div class="points_area" id='points_area_<?php echo $move['main']->mvid; ?>'>
      <div class="points">
      <?php
      //var_dump($move['main']);
      ?>
<?php
$mplast = 0;
//var_dump($move['mp']);
  if ((isset($move['mp']))&&(isset($move['mp'][0]))&&(isset($move['mp'][0]['id_move']))&&(!empty($move['mp'][0]['id_move'])))
  foreach ($move['mp'] as $k=>$mpt)
    {
    $mplast = $k + 1;
      if (isset($mpt['id_move']))
        {
          ?>
          <div class="mpt_group" id="mpt_group_<?php if (isset($mpt['mptid']))echo $mpt['mptid']; ?>">
          <h3>Point #<?php if (isset($mplast))echo $mplast; ?></h3>
          <div class="mpt_inner_group">
<?php switch ($mpt['method']) {
case 'move_point' : ?>
<table>

    <tr>
    <td colspan="2">
    Use Method of manipulation
    </td>
    <td colspan="2">
    <select name="single[move_point][transform_method][]">
<?php
  //$transform_methods = array(1=>'Use animation', 2=>'Use transition');
  foreach ($transform_methods as $tm_key=>$tm)
    {
 ?>
    <option value="<?php echo $tm_key; ?>" <?php if ($mpt['transform_method'] == $tm_key)echo 'selected="selected"'; ?>><?php echo $tm; ?></option>
    <?php
    }
    ?>
    </select>
    </td>
    </tr>

<tr>
<td>
Size %
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][size][]" value='<?php if (isset($mpt['size']))echo $mpt['size']; ?>'>  
</td>

<td>
Opacity %
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][opacity][]" value='<?php if (isset($mpt['opacity']))echo $mpt['opacity']; ?>'>  
</td>

<td>
Position x
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][posx][]" value='<?php if (isset($mpt['posx']))echo $mpt['posx']; ?>'>  
</td>

</tr>

<tr>

<td>
Position y
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][posy][]" value='<?php if (isset($mpt['posy']))echo $mpt['posy']; ?>'>  
</td>

<td>
Position x out
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][posxout][]" value='<?php if (isset($mpt['posxout']))echo $mpt['posxout']; ?>'>  
</td>

<td>
Position y out
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][posyout][]" value='<?php if (isset($mpt['posyout']))echo $mpt['posyout']; ?>'>  
</td>

</tr>

<tr>

<td>
Duration
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][duration][]" value='<?php if (isset($mpt['mptduration']))echo $mpt['mptduration']; ?>'>  
</td>

<td>
Easing
</td>
<td>
    <select name="single[move_point][easing][]">
    <?php
    $init_easing = $mpt['easing'];
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
    <input type="text" class="notempty_fld" name="single[move_point][method][]" value='<?php if (isset($mpt['method']))echo $mpt['method']; ?>'>  
</td>

</tr>

<tr>

<td>
Rotation
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][rotation][]" value='<?php if (isset($mpt['rotation']))echo $mpt['rotation']; ?>'>  
</td>

<td>
Rotation origin
</td>
<td>
    <input type="text" class="notempty_fld" name="single[move_point][rotation_origin][]" value='<?php if (isset($mpt['rotation_origin']))echo $mpt['rotation_origin']; ?>'>  
</td>
    <td>
    Rotation 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[move_point][rotation3d][]" value="<?php if (isset($mpt['rotation3d'])) echo $mpt['rotation3d']; ?>">
    </td>
</tr>
<tr>
    <td>
    Scale 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[move_point][scale3d][]" value="<?php if (isset($mpt['scale3d'])) echo $mpt['scale3d']; ?>">
    </td>
    <td>
    Translate 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[move_point][translate3d][]" value="<?php if (isset($mpt['translate3d'])) echo $mpt['translate3d']; ?>">
    </td>
    <td>
    Transform 3d origin
    </td><td>
    <input type="text" class="notempty_fld" name="single[move_point][transform3d_origin][]" value="<?php if (isset($mpt['transform3d_origin'])) echo $mpt['transform3d_origin']; ?>">
    </td>
</tr>
<tr>
<td>
Action
</td>
<td>
    <button name="remove_point" class="remove_point" id="remove_point_<?php if (isset($mpt['mptid']))echo $mpt['mptid']; ?>" style="float:right;">Remove</button>
    <input type="hidden" name="single[move_point][id][]" value='<?php if (isset($mpt['mptid']))echo $mpt['mptid']; ?>'>  
</td>


</tr>
</table>
<?php
break;
case 'delay_point':
?>
<table>
<tr>
<td>
Duration
</td>
<td>
    <input type="text" class="digits_fld" name="single[move_point][duration][]" value='<?php if (isset($mpt['mptduration']))echo $mpt['mptduration']; ?>'>  
</td>

<td>
Method
</td>
<td>
    <input type="text" class="notempty_fld" name="single[move_point][method][]" value='<?php if (isset($mpt['method']))echo $mpt['method']; ?>'>  
</td>
<td>
Action
</td>
<td>
    <button name="remove_point" class="remove_point" id="remove_point_<?php if (isset($mpt['mptid']))echo $mpt['mptid']; ?>" style="float:right;">Remove</button>
    <input type="hidden" name="single[move_point][id][]" value='<?php if (isset($mpt['mptid']))echo $mpt['mptid']; ?>'>  
    
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
<?php
break;
  }
?>

          </div>
          </div>
          <?php
        }
    }
?>
      </div>      
      <?php
        echo "<div class='mplast' id='mplast_".$move['main']->mvid."'>$mplast</div>";
      ?>
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
  //$transform_methods = array(1=>'Use animation', 2=>'Use transition');
  foreach ($transform_methods as $tm_key=>$tm)
    {
 ?>
    <option value="<?php echo $tm_key; ?>" <?php if ($move['main']->finish_transform_method == $tm_key)echo 'selected="selected"'; ?>><?php echo $tm; ?></option>
    <?php
    }
    ?>
    </select>
    </td>
    </tr>
    
    <tr>
    <td>
    Finish size %
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_size][]" value="<?php if (isset($move['main']->finish_size)) echo $move['main']->finish_size; ?>">
    </td>
    <td>
    Finish opacity %
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_opacity][]" value="<?php if (isset($move['main']->finish_opacity)) echo $move['main']->finish_opacity; ?>">
    </td>
    <td>
    Finish position x in
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_posxin][]" value="<?php if (isset($move['main']->finish_posxin)) echo $move['main']->finish_posxin; ?>">
    </td>
    </tr>

    <tr>
    <td>
    Finish position x out
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_posxout][]" value="<?php if (isset($move['main']->finish_posxout)) echo $move['main']->finish_posxout; ?>">
    </td>
    <td>
    Finish position y in
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_posyin][]" value="<?php if (isset($move['main']->finish_posyin)) echo $move['main']->finish_posyin; ?>">
    </td>
    <td>
    Finish position y out
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_posyout][]" value="<?php if (isset($move['main']->finish_posyout)) echo $move['main']->finish_posyout; ?>">
    </td>
    </tr>

    <tr>
    <td>
    Finish duration
    </td><td>
    <input type="text" class="digits_fld" name="single[finish_duration][]" value="<?php if (isset($move['main']->finish_duration)) echo $move['main']->finish_duration; ?>">
    </td>
    <td>
    Finish easing
    </td><td>
    <select name="single[finish_easing][]">
    <?php
    foreach ($easings as $ease)
      {
        if ($ease == $move['main']->finish_easing)
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
    $methods_finish = array('left_bottom', 'left_top', 'left_right', 'right_bottom', 'right_top', 'right_left', 'top_bottom', 'top_right', 'top_left', 'bottom_top', 'bottom_right', 'bottom_left', 'to');
    foreach ($methods_finish as $mt)
      {
        if ($mt == $move['main']->finish_method)
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
    <input type="text" class="digits_fld" name="single[finish_rotation][]" value="<?php if (isset($move['main']->finish_rotation)) echo $move['main']->finish_rotation; ?>">
    </td>
    <td>
    Finish rotation origin
    </td><td>
    <input type="text" class="notempty_fld" name="single[finish_rotation_origin][]" value="<?php if (isset($move['main']->finish_rotation_origin)) echo $move['main']->finish_rotation_origin; ?>">
    </td>
    <td>
    Finish rotation 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[finish_rotation3d][]" value="<?php if (isset($move['main']->finish_rotation3d)) echo $move['main']->finish_rotation3d; ?>">
    </td>
    </tr>
    <tr>
    <td>
    Finish scale 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[finish_scale3d][]" value="<?php if (isset($move['main']->finish_scale3d)) echo $move['main']->finish_scale3d; ?>">
    </td>
    <td>
    Finish translate 3d
    </td><td>
    <input type="text" class="notempty_fld" name="single[finish_translate3d][]" value="<?php if (isset($move['main']->finish_translate3d)) echo $move['main']->finish_translate3d; ?>">
    </td>
    
    <td>
    Finish transform 3d origin
    </td><td>
    <input type="text" class="notempty_fld" name="single[finish_transform3d_origin][]" value="<?php if (isset($move['main']->finish_transform3d_origin)) echo $move['main']->finish_transform3d_origin; ?>">
    </td>
    </tr>

    <tr>
    <td>
    Width
    </td><td>
    <input type="text" class="digits_fld" name="single[width][]" value="<?php if (isset($move['main']->width)) echo $move['main']->width; ?>">
    </td>
    <td>
    Height
    </td><td>
    <input type="text" class="digits_fld" name="single[height][]" value="<?php if (isset($move['main']->height)) echo $move['main']->height; ?>">
    </td>
    <td>
    Font size
    </td><td>
    <input type="text" class="digits_fld" name="single[font_size][]" value="<?php if (isset($move['main']->font_size)) echo $move['main']->font_size; ?>">
    </td>
    </tr>
    <tr><td colspan="6">
      <button name="remove_accordion" id="remove_accordion_<?php echo $move['main']->mvid; ?>" style="float:right;">Remove</button>
    </td></tr>
    </table>
    <input type="hidden" name="single[moveid][]" value='<?php echo $move['main']->mvid; ?>'>
    </div>
  </div>
<?php
  }
?>
</div>
</div>

<input type="hidden" name="num_items_<?php echo $container->id; ?>" value="<?php $num_items++; echo $num_items; ?>">
      <input type="submit" value=" Save this container " name="container_save_btn">
    <input type="submit" value=" Delete this container " name="container_del_btn">

  </form>
</div>
</div>

<!--
<div class="bottom_up_down">
<div class="up_btn"><img src='<?php echo plugins_url("../../images/up.png", __FILE__); ?>'></div>
<div class="down_btn"><img src='<?php echo plugins_url("../../images/down.png", __FILE__); ?>'></div>
</div>
-->

<div class="clear_line"></div>
</div>


  

<?php } ?>
<?php } 
      else
      {
        echo "<h1>Container key or project id failed.</h1>";
      }
?>
</div>

<div id="last_number_container"><?php if (isset($container_num)) echo $container_num; else echo 0; ?></div>

<div class="container_hidden_num"></div>
