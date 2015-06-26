<h2>Slider Groups</h2>
<p>Important : To update group name, enter new name in text input and press update button near the required group.</p>
<form method="POST" id="groupsfrm" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=4&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
<input type="text" name="group_name">
<input type="hidden" name="id_main" value="<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
<button id="add_group" name="add_group_btn">Add Group</button><br>
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('groups');
    }
  ?>
<h3>Groups</h3>
<table id="tbl_group">
<?php
if ((isset($group_info))&&(!empty($group_info)))
foreach ($group_info as $gr)
  {
  echo "<tr><td>";
  echo $gr->name;
  echo "</td><td>";
  
  echo "<button name='del_group_btn' value='".$gr->id."'>Delete</button>";
  echo "<button name='upd_group_btn' value='".$gr->id."'>Update</button>";
  echo "</td></tr>";
  }
?>
</table>
</form>
