<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Controller_Main extends Sial_Controller{
private $model_main;

public function __construct($model_main)
  {
  parent::__construct();
    $this->model_main = $model_main;
  }
public function execute($proj_id)
  {
    return $this->model_main->get_main_results($proj_id);
  }
public static function register_scripts_fronend()
  {
  $helper = new Sial_Helper();
  
    $helper->registerStylefront("subitem_al_slider_common", "css/subitem_al_slider_common.css");

    $helper->registerScryptfront("subitem_al_slider_modernizr_js", "js/subitem_al_slider_modernizr.js");
    $helper->registerScryptfront("subitem_al_slider_common_js", "js/subitem_al_slider_common.js");
    
  global $jquery_ui_library_use;
  if ($jquery_ui_library_use)
    {
      $helper->registerStylefront("jquery-ui-css", "css/jquery-ui.css");
    }
    
  }
public static function print_scripts_fronend()
  {
  global $subitemal_adding_scripts;
  if ($subitemal_adding_scripts !== true)return;

  $helper = new Sial_Helper();
  
    $helper->printStylefront("subitem_al_slider_common", "css/subitem_al_slider_common.css");

    $helper->printScryptfront("subitem_al_slider_modernizr_js", "js/subitem_al_slider_modernizr.js");
    $helper->printScryptfront("subitem_al_slider_common_js", "js/subitem_al_slider_common.js");
    
  global $jquery_ui_library_use;
  if ($jquery_ui_library_use)
    {
      $helper->printStylefront("jquery-ui-css", "css/jquery-ui.css");
    }
    
  }
public static function add_scripts_fronend()
  {
  $helper = new Sial_Helper();

    $helper->addStyle("subitem_al_slider_common", "css/subitem_al_slider_common.css");

    $helper->addScryptfront("subitem_al_slider_modernizr", "js/subitem_al_slider_modernizr.js");
    $helper->addScryptfront("subitem_al_slider_common_js", "js/subitem_al_slider_common.js");
    
  global $jquery_ui_library_use;
  if ($jquery_ui_library_use)
    {
      $helper->addStyle("jquery-ui-css", "css/jquery-ui.css");
    }
    
  }


}