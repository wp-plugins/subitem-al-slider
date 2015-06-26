<?php	
defined('ABSPATH') or die("No script kiddies please!");

if(function_exists('current_user_can'))
if(!current_user_can('manage_options')) {
die('Access Denied');
}
if(!function_exists('current_user_can')){
  die('Access Denied');
}
?>

<?php if (isset($_GET['updated'])) { ?>
<div class="updated"><strong><?php _e('Settings saved.') ?></strong></div>
<?php } ?>

  <script>
  var groups;
  var containers_img;
  var containers_txt;
jQuery(document).ready(function($) {


  groups = jQuery.parseJSON('<?php echo json_encode($group_info); ?>');
  containers_img = jQuery.parseJSON('<?php echo json_encode($image_info); ?>');
  containers_txt = jQuery.parseJSON('<?php echo json_encode($text_info); ?>');
    
    $('#button_show_add_project').addClass('button');
    $('.set_backgrounds').addClass('button');
    $( "input[type=submit], button" ).addClass('button');

      if (empty($('#projects').val())) 
        {
        $( "input[type=submit], button" ).not('.any').each(function(){
        if ((($(this).attr("id")) != 'button_show_add_project')&&(($(this).attr("id")) != 'new_project_create_id_btn')&&
        (($(this).attr("id")) != 'new_project_close_id_btn'))
          {
          $(this).attr("disabled", "disabled");
          }
        });
        }

function empty(element) {
    if (
            element === ""          ||
            element === 0           ||
            element === "0"         ||
            element === null        ||
            element === "NULL"      ||
            element === "null"      ||
            element === undefined   ||
            element === false
        ) {
        return true;
    }
    if (typeof(element) === 'object') {
        var i = 0;
        for (key in element) {
            i++;
        }
        if (i === 0) { return true; }
    }
    return false;
}

$('.new_project_close_btn').unbind('click').bind('click', function(event){
              event.preventDefault();
$( ".new_project_show_dlg" ).hide();
});
        
$('#button_show_add_project').unbind('click').bind('click', function(event) {
            event.preventDefault();
$( ".new_project_show_dlg" ).show();
  });

  
window.alert_show = function(msg, type)
  {
  alert(msg);
  }

    $('#projects').change( function() {
      location.href = "<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=0&pid="+$('#projects').val();
    });

jQuery.validator.setDefaults({
  debug: true,
  success: "valid"
});

var remove_rules = function(selector)
  {
selector.each(function (key,item) {
if (!empty($(item)[0].form))
  $(item).rules('remove');
});
  }
function attach_froms(selector)
  {
 selector.each(function(key, item){
    $(item).validate();
  });
  }
function detach_froms(selector)
  {
  var form = selector.get(0);
    $.removeData(form,'validator');
    selector.removeData('validator')
  }
  
var adding_fields_rules_oneform = function(sel)
 {

  $(sel).find(".digits_fld").each(function (key,item) {
  if (!empty($(item)[0].form))
  {
  if (!$.isEmptyObject($(item).rules()))
    $(item).rules('remove');
    
  $(item).rules('add', {

  number: true,
  messages: {
    required: 'This field must be number'
    }
  });
  }
  });

  $(sel).find(".notempty_fld").each(function (key,item) {
  if (!empty($(item)[0].form))
    {
  if (!$.isEmptyObject($(item).rules()))
    $(item).rules('remove');
    
  $(item).rules('add', {
  required: true,
  messages: {
    required: 'This field must be filled'
    }
  });
  }
  });

  $(sel).find(".url_fld").each(function (key,item) {
  if (!empty($(item)[0].form))
  {
  if (!$.isEmptyObject($(item).rules()))
    $(item).rules('remove');

  $(item).rules('add', {
  required: true,
  url: true,
  messages: {
    required: 'This field must be url'
    }
  });
  }
  });
 }
  
/*
Remove hdn class
*/
window.remove_class_hdn = function(source)
  {
    $(source).find(".hdn").each(function(key, item){
    var oldi = item.outerHTML;
    var newi = $(item).removeClass("hdn")[0].outerHTML;
      source = source.replace(oldi, newi);
    });
    return source;
  }
/*
Functions for form submit validation
*/
function check_for_valid(event, selector, type)
{
  if (!$(selector).valid()){
        all_submits();
        return false;
      }
      
   return true;
}

function event_submit_main(){
$('.main_info_frm').unbind('submit').bind('submit', function(event){
  return submit_inner(event, '.main_info_frm');
});
}
event_submit_main();
function submit_inner(event, id_selector)
{
  remove_rules($(id_selector));
  detach_froms($(id_selector));

    attach_froms($(id_selector));
      adding_fields_rules_oneform(id_selector);

  if (!$(id_selector).valid()){
        event_submit_main();
    return false;
  }
  else
  {
    return true;
  }
}
window.all_submits = function()
{
function event_submit_bg(){
$('.bg_info_frm').unbind('submit').bind('submit', function(event){
    return sbm_frm(event, '.bg_info_frm', $(this));
});
}
event_submit_bg();
function event_submit_img(){
$('.img_frm').unbind('submit').bind('submit', function(event){
    return sbm_frm(event, '.img_frm', $(this));
});
}
event_submit_img();
function event_submit_txt(){
$('.txt_frm').unbind('submit').bind('submit', function(event){
    return sbm_frm(event, '.txt_frm', $(this));
});
}
event_submit_txt();
function event_submit_settings(){
$('.settings_frm').unbind('submit').bind('submit', function(event){
    return sbm_frm(event, '.settings_frm', $(this));
});
}
event_submit_settings();

$('.container_frm').unbind('submit').bind('submit', function(event){
  validate_big_form(event, '.container_frm', $(this));
    
});

}
all_submits();
/*
Validation form
*/
function sbm_frm(event, defselector, elem)
  {
  var id_arr = elem.attr("id").split("frm_");
  var selector = "#"+defselector.substr(1)+"_"+id_arr[1];

  detach_froms($(selector));
    attach_froms($(selector));
      adding_fields_rules_oneform(selector);
      return check_for_valid(event, selector, defselector.substr(1));
  }

function validate_big_form(event, defselector, elem)
{
$('.container_frm__errors').html("");
var big_frm_errors = [];
  var id_arr = elem.attr("id").split("frm_");
  var selector = "#"+defselector.substr(1)+"_"+id_arr[1];
  $(selector).find(".notempty_fld").each(function (key,item) {
    if ((empty(item))||($(item).val() == ''))
      big_frm_errors.push("Validation Error (not empty check): Field - '"+$(item).parent().prev().html()+"'");
  });
  $(selector).find(".digits_fld").each(function (key,item) {
    if ((empty(item))||(!$.isNumeric($(item).val())))
      big_frm_errors.push("Validation Error (digit check): Field - '"+$(item).parent().prev().html()+"'");
  });

  if (big_frm_errors.length === 0)
              {

              }
              else
              {
              event.preventDefault();
              var newsel = selector+"_errors";
                $(newsel).html("<br>"+big_frm_errors.join("<br>"));
              }
}  


});
</script>

<div id="dialog-message"></div>

<div id="bg_nonce"><?php 
if (function_exists('wp_create_nonce'))
    {
echo wp_create_nonce("upd_rec");
    }
 ?></div>

<div id="image_nonce"><?php 
if (function_exists('wp_create_nonce'))
    {
echo wp_create_nonce("upd_rec_img");
    }
 ?></div>
 
 <div id="text_nonce"><?php 
if (function_exists('wp_create_nonce'))
    {
echo wp_create_nonce("upd_rec_txt");
    }
 ?></div>
 <div id="container_nonce"><?php 
if (function_exists('wp_create_nonce'))
    {
echo wp_create_nonce("upd_rec_container");
    }
 ?></div>
 <div id="item_nonce"><?php 
if (function_exists('wp_create_nonce'))
    {
echo wp_create_nonce("upd_rec_item");
    }
 ?></div>
 <div id="move_nonce"><?php 
if (function_exists('wp_create_nonce'))
    {
echo wp_create_nonce("upd_rec_move");
    }
 ?></div>

<div><img src='<?php echo plugins_url("../images/caption.png", __FILE__); ?>'></div>
 
<div style="display:table;">
<div style="float:left;width:50%;">
 Projects 
 <select name="cur_project" id="projects">
 <?php
 foreach ($all_projects as $project)
  {
  if ($proj_id == $project->id)
  echo "<option value='".$project->id."' selected='selected'>".$project->name."(id:".$project->id.")</option>";
  else
  echo "<option value='".$project->id."'>".$project->name."(id:".$project->id.")</option>";
  }
 ?>
 </select>
 <button name="new_project" id="button_show_add_project">Create new project</button>

<form id="projdel" name="project_delete_form" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=0">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_project_del');
    }
  ?>
<input type="hidden" name="proj_id" value="<?php if (isset($_GET['pid'])&&(!empty($_GET['pid'])))echo $_GET['pid']; else echo $proj_id; ?>">
<input type="submit" name="del_proj_btn" value="Delete">
</form>
 
 <div class="new_project_show_dlg" title="New project creation"  style="display:none;/*border:1px solid black;background-color:#fff;width:350px;padding-left:20px;*/">
  <form id="pcf" name="project_creation_form" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>?page=sial_slider_show&active=0">
  <?php
  if (function_exists('wp_nonce_field'))
    {
    wp_nonce_field('sp_project_name');
    }
  ?>
<div class="panel panel-primary">
<div class="panel-heading">

 <h3 class="add_proj_header2 panel-title">New project</h3>
 
 </div>
<div class="panel-body">

 <input type="text" name="new_project_name" value="" id="new_project_name">
 <input type="hidden" name="new_project_btn" value="Add project" id="add_proj_btn">
 <input type="submit" id="new_project_create_id_btn" value="Create">
 <input type="submit" id="new_project_close_id_btn" class="new_project_close_btn"  value="Close">
 
  </div>
   </div>
   
  </form>
 </div>
</div>
<?php
    $actual_link = 'http' . (isset($_SERVER['HTTPS']) ? 's' : '') . '://' . "$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";

    if (preg_match("/&active=\d+/", $actual_link) != 0)
      {
                        $actual_link0 = preg_replace("/&active=\d+/", "&active=0", $actual_link);
                        $actual_link1 = preg_replace("/&active=\d+/", "&active=1", $actual_link);
                        $actual_link2 = preg_replace("/&active=\d+/", "&active=2", $actual_link);
                        $actual_link3 = preg_replace("/&active=\d+/", "&active=3", $actual_link);
                        $actual_link4 = preg_replace("/&active=\d+/", "&active=4", $actual_link);
                        $actual_link5 = preg_replace("/&active=\d+/", "&active=5", $actual_link);
                        $actual_link6 = preg_replace("/&active=\d+/", "&active=6", $actual_link);
      }
      else
      {
                        $actual_link0 = $actual_link."&active=0";
                        $actual_link1 = $actual_link."&active=1";
                        $actual_link2 = $actual_link."&active=2";
                        $actual_link3 = $actual_link."&active=3";
                        $actual_link4 = $actual_link."&active=4";
                        $actual_link5 = $actual_link."&active=5";
                        $actual_link6 = $actual_link."&active=6";
      }
    if (preg_match("/pid=\d+/", $actual_link) == 0)
      {
                        $actual_link0 .= "&pid=".((isset($_GET['pid'])) ? $_GET['pid'] : $proj_id);
                        $actual_link1 .= "&pid=".((isset($_GET['pid'])) ? $_GET['pid'] : $proj_id);
                        $actual_link2 .= "&pid=".((isset($_GET['pid'])) ? $_GET['pid'] : $proj_id);
                        $actual_link3 .= "&pid=".((isset($_GET['pid'])) ? $_GET['pid'] : $proj_id);
                        $actual_link4 .= "&pid=".((isset($_GET['pid'])) ? $_GET['pid'] : $proj_id);
                        $actual_link5 .= "&pid=".((isset($_GET['pid'])) ? $_GET['pid'] : $proj_id);
                        $actual_link6 .= "&pid=".((isset($_GET['pid'])) ? $_GET['pid'] : $proj_id);
      }

?>
<div id="tabs" style="display:table-cell;float:right;width:49%;vertical-align:top;">
  <ul style="margin-top:0px;text-align:center;">
    <li class="button button-primary"><a href="<?php echo $actual_link0; ?>" style="color:#fff;text-decoration:none;">Slider Main Info</a></li>
    <li class="button button-primary"><a href="<?php echo $actual_link1; ?>" style="color:#fff;text-decoration:none;">Slider Containers</a></li>
    <li class="button button-primary"><a href="<?php echo $actual_link2; ?>" style="color:#fff;text-decoration:none;">Slider Items</a></li>
    <li class="button button-primary"><a href="<?php echo $actual_link3; ?>" style="color:#fff;text-decoration:none;">Import/Export</a></li>
    <li class="button button-primary"><a href="<?php echo $actual_link4; ?>" style="color:#fff;text-decoration:none;">Slider Groups</a></li>
    <li class="button button-primary"><a href="<?php echo $actual_link5; ?>" style="color:#fff;text-decoration:none;">Slider Settings</a></li>
    <li class="button button-primary"><a href="<?php echo $actual_link6; ?>" style="color:#fff;text-decoration:none;">Slider Paste Code</a></li>
  </ul>
</div>
 
</div>