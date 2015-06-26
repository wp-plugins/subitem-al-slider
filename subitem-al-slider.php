<?php
/*
Plugin Name: Sub Item Al Slider
Description: Slider with ability to make containers from sub items.
Version: 1.0.0
Author: alexdtn (<a href="http://al-plugins.biz/">homesite</a>)
*/

namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

if (is_admin())
 {
  if(!function_exists('wp_get_current_user')) {
    include(ABSPATH . "wp-includes/pluggable.php"); 
  }
  if (is_user_logged_in())
   {
   if ( current_user_can('edit_plugins') || current_user_can('install_plugins') || current_user_can('activate_plugins') ||
   current_user_can('delete_plugins') || current_user_can('update_plugins') ) {
    try
    {
    require_once dirname(__FILE__).'/inc/inclusion.php';
    } catch (Exception $e){
      echo $e->getMessage();
    }

    
    require_once dirname(__FILE__).'/admin_subitem_al_slider.php';
    try
    {
      $admin = new Sial_Admin(__FILE__);
    } catch (Exception $e){
      echo $e->getMessage();
    }
   }
  }
 }
  else
  {
  require_once dirname(__FILE__).'/inc/inclusion_front.php';

    require_once dirname(__FILE__).'/users_subitem_al_slider.php';

      //Main slider output
    add_shortcode('subitem_al_slider', array('\subitemal\Sial_Users', 'subitem_al_slider'));
      
  }
