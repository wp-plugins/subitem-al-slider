<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Sial_Controller extends Sial_Base{

public function __construct()
  {
  if (method_exists(get_parent_class(), '__construct'))
      parent::__construct();
  }
public function check($nounce)
  {
   if (function_exists('current_user_can') &&
      !current_user_can('manage_options') )
   die (_e('Access Forbidden'));
    
  if (function_exists('check_admin_referer'))
    {
    check_admin_referer($nounce);
    }
  }
public function check_ajax($nounce, $var)
  {
  if (function_exists('current_user_can') &&
    !current_user_can('manage_options') )
    die (_e('Access Forbidden'));

  if (function_exists('check_ajax_referer'))
    {
    check_ajax_referer($nounce, $var);
    }
  }

}
?>