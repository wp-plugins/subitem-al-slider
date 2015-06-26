<h3>Usefull Info</h3>
<p>
Before use import/export features check folder export in plugin directory for write permissions for the script. Set phar.readonly = 0 in php.ini file if absent.
</p>
<p style='font-weight:bold;'><em>To Import :</em><p>
<p>
If you can set up in php.ini upload_max_filesize, post_max_size and max_input_time you can upload exported earlier file and execute
using button upload. If you haven't access to php.ini you can upload exported earlier file into export placed in plugin directory,
and choose file in the list.
</p>
<p style='font-weight:bold;'><em>To Export :</em><p>
<p>
Just click on export button and get file in export directory. 
</p>
<p style='font-weight:bold;'>
Advice : Execute import only once when you install plugin.
</p>
<form method="POST" id="imexpfrm" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=0&pid=<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>" enctype="multipart/form-data">
<input type="hidden" name="MAX_FILE_SIZE" value="400194304" /> 
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('impexp');
    }
  ?>
<h3>Import</h3>
<input type='file' name='import'>
<select name='imported'>
<option value='none'>None</option>
<?php
if ((isset($files_for_import))&&(!empty($files_for_import)))
foreach ($files_for_import as $fl)
  {
  echo "<option value='".$fl."'>".basename($fl)."</option>";
  }
?>
</select>
<button id='import_btn' name="import_btn" class='any' value="1" onclick="javascript:$('#imexpfrm').submit();">Import</button><br>
<h3>Export</h3>
<button id='export_btn' name="export_btn" value="1" onclick="javascript:$('#imexpfrm').submit();">Export</button>
</form>
</div>
