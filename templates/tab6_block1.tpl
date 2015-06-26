<h2>Slider Settings</h2>

<div class="panel panel-primary">
<div class="panel-heading">

<form method="POST" id="settings_frm_1" class="settings_frm" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=5&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
  <input type="hidden" name="pid" value="<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('settings_buttons');
    }
  ?>

<h3 class="panel-title">Slider Buttons</h3>

 </div>
<div class="panel-body">

<table id="tbl_settings">
<?php
$settings_ind = range(3, 9);
foreach ($settings_ind as $setts)
  {
  echo "<tr><td>";
  if ((isset($main_info[0]))&&($main_info[0]->settings_buttons == $setts))
    echo "<input type='radio' name='settings_buttons' checked='checked' value='".$setts."'>";
      else
    echo "<input type='radio' name='settings_buttons' value='".$setts."'>";
  echo "</td><td>";
  echo "Buttons #".$setts;
  echo "</td><td>";
  echo "<img src='".plugins_url("../images/arrow_left_0".$setts.".png", __FILE__)."'>";
  echo "<img src='".plugins_url("../images/arrow_right_0".$setts.".png", __FILE__)."'>";
  echo "</td></tr>";
  }
  echo "<tr><td>";
  if ((isset($main_info[0]))&&($main_info[0]->settings_buttons == 0))
    echo "<input type='radio' name='settings_buttons' checked='checked' value='".(0)."'>";
      else
    echo "<input type='radio' name='settings_buttons' value='".(0)."'>";
  echo "</td><td>";
  echo "Buttons";
  echo "</td><td>";
  echo "Don't show buttons";
  echo "</td></tr>";

?>
</table>
<div style="float:left;">
<h3>Buttons Offset Top</h3>
<table>
<tr><td>
<div style='font-weight:bold;'>Offset</div>
</td>
<td>
<input type="text" class="digits_fld" name="settings_buttons_top" value="<?php if (isset($main_info[0]))echo $main_info[0]->settings_buttons_top; ?>">
</td><td>
(If 0 - "Default top offset")
</td>
</tr>
</table>
</div>
<br>
<div style="float:left;">
<h3>Buttons Transparency</h3>
<table>
<tr><td>
<div style='font-weight:bold;'>Transparency (%)</div>
</td>
<td>
<input type="text" class="digits_fld" name="settings_buttons_opacity" value="<?php if (isset($main_info[0]))echo $main_info[0]->settings_buttons_opacity; ?>">
</td><td>
</td>
</tr>
</table>
</div>
<br>
<div>
<h3>Buttons Width</h3>
<table>
<tr><td>
<div style='font-weight:bold;'>Width (buttons width = container width * this parameter / 1600)</div>
</td>
<td>
<input type="text" class="digits_fld" name="settings_buttons_width" value="<?php if (isset($main_info[0]))echo $main_info[0]->settings_buttons_width; ?>">
</td><td>
</td>
</tr>
</table>
</div>

<input type="submit" name="settings_buttons_save_btn" value="Save">
</form>

 </div>
  </div>

<div class="panel panel-primary">
<div class="panel-heading">
  
<form method="POST" id="settings_indicators_frm_1" class="settings_indicators_frm" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=5&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
  <input type="hidden" name="pid" value="<?php if (isset($_GET['pid']))echo $_GET['pid']; else echo $proj_id; ?>">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('settings_indicators');
    }
  ?>
  
<h3 class="panel-title">Slide Indicators</h3>

 </div>
<div class="panel-body">

<table id="tbl_settings">
<?php
$settings_ind = range(1, 5);
foreach ($settings_ind as $setts)
  {
  echo "<tr><td>";
  if ((isset($main_info[0]))&&($main_info[0]->settings_indicators == $setts))
    echo "<input type='radio' name='settings_indicators' checked='checked' value='".$setts."'>";
      else
    echo "<input type='radio' name='settings_indicators' value='".$setts."'>";
  echo "</td><td>";
  echo "Indicators #".$setts;
  echo "</td><td>";
  echo "<img src='".plugins_url("../images/slide_empty_0".$setts.".png", __FILE__)."'>";
  echo "<img src='".plugins_url("../images/slide_filled_0".$setts.".png", __FILE__)."'>";
  echo "</td></tr>";
  }
  echo "<tr><td>";
  if ((isset($main_info[0]))&&($main_info[0]->settings_indicators == 0))
    echo "<input type='radio' name='settings_indicators' checked='checked' value='".(0)."'>";
      else
    echo "<input type='radio' name='settings_indicators' value='".(0)."'>";
  echo "</td><td>";
  echo "Indicators";
  echo "</td><td>";
  echo "Don't show indicators";
  echo "</td></tr>";

?>
</table>
<h3>Indicators parameters</h3>
<table>
<tr><td>
<div style='font-weight:bold;'>Top Offset</div>
</td><td>
<input type="text" class="digits_fld" name="settings_indicators_top" value="<?php if (isset($main_info[0]))echo $main_info[0]->settings_indicators_top; ?>">
</td><td>
(If 0 - "Default indicator's top offset")
</td></tr>

<tr><td>
<div style='font-weight:bold;'>Width</div>
</td><td>
<input type="text" class="digits_fld" name="settings_indicators_width" value="<?php if (isset($main_info[0]))echo $main_info[0]->settings_indicators_width; ?>">
</td><td>
(If 0 - "Default indicator's width")
</td></tr>

<tr><td>
<div style='font-weight:bold;'>Front number of indicators by one side</div>
</td><td>
<input type="text" class="digits_fld" name="settings_num_indicators" value="<?php if (isset($main_info[0]))echo $main_info[0]->settings_num_indicators; ?>">
</td><td>
</td></tr>

</table>
<input type="submit" name="settings_indicators_save_btn" value="Save">
</form>

 </div>
  </div>