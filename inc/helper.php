<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Sial_Helper{
public $plugin_dir;

public function __construct()
  {

  }
public function addStyle($handle, $path)
  {
  $currStyleFile = plugin_dir_path( __FILE__ )."/../".$path;
  $currStyleUrl = plugins_url("/../".$path, __FILE__);

        if ( file_exists($currStyleFile) ) {
            wp_register_style($handle, $currStyleUrl);
            wp_enqueue_style($handle);
        }
  }
public function addScrypt($handle, $path)
  {
  global $is_slide_page;
  
  $currScryptFile = plugin_dir_path( __FILE__ )."/../".$path;
    $currScryptUrl = plugins_url("/../".$path, __FILE__);

        if ( file_exists($currScryptFile) ) {
    
    if ($is_slide_page == 'slide')
            wp_register_script($handle, $currScryptUrl, array('jquery', 'jquery-ui-core', 'jquery-ui-accordion', 'jquery-ui-tabs', 'jquery-ui-button', 'jquery-ui-dialog'), '1.0', true);
            else
            wp_register_script($handle, $currScryptUrl, array('jquery'), '1.0', true);
            
              wp_localize_script($handle, 'subitem_al_WPURLS', array( 'pluginurl' => trailingslashit( plugin_dir_url( __FILE__ ) ) ));
            wp_print_scripts($handle);
        }

  }
public function addScryptfront($handle, $path)
  {
  global $is_slide_page;
  
  $currScryptFile = plugin_dir_path( __FILE__ )."/../".$path;
    $currScryptUrl = plugins_url("/../".$path, __FILE__);

        if ( file_exists($currScryptFile) ) {
    
            wp_register_script($handle, $currScryptUrl, array('jquery'), '1.0', true);
            
              wp_localize_script($handle, 'subitem_al_WPURLS', array( 'pluginurl' => trailingslashit( plugin_dir_url( __FILE__ ) ) ));
            wp_print_scripts($handle);
        }

  }

public function registerStylefront($handle, $path)
  {
  $currStyleFile = plugin_dir_path( __FILE__ )."/../".$path;
  $currStyleUrl = plugins_url("/../".$path, __FILE__);

        if ( file_exists($currStyleFile) ) {
            wp_register_style($handle, $currStyleUrl);
        }
  }

public function registerScryptfront($handle, $path)
  {
  $currScryptFile = plugin_dir_path( __FILE__ )."/../".$path;
    $currScryptUrl = plugins_url("/../".$path, __FILE__);

        if ( file_exists($currScryptFile) ) {

  global $jquery_ui_library_use;
  if ($jquery_ui_library_use)
    {
      wp_register_script($handle, $currScryptUrl, array('jquery', 'jquery-ui-core', 'jquery-effects-core', 'jquery-effects-blind', 'jquery-effects-bounce', 'jquery-effects-clip',
      'jquery-effects-drop', 'jquery-effects-explode', 'jquery-effects-fade', 'jquery-effects-fold', 'jquery-effects-highlight',
      'jquery-effects-pulsate', 'jquery-effects-scale', 'jquery-effects-shake', 'jquery-effects-slide', 'jquery-effects-transfer'), '1.0', true);
    }
    else
    {
      wp_register_script($handle, $currScryptUrl, array('jquery'), '1.0', true);
    }
    
        }

  }
public function printStylefront($handle, $path)
  {
  $currStyleFile = plugin_dir_path( __FILE__ )."/../".$path;
  $currStyleUrl = plugins_url("/../".$path, __FILE__);

        if ( file_exists($currStyleFile) ) {
        echo "<link rel='stylesheet' property='stylesheet' id='".$handle."'  href='".$currStyleUrl."?ver=4.1.1' type='text/css' media='all' />";
        /*
           global $wp_styles;
              $wp_styles->add($handle, $path);
              $wp_styles->add_data($handle, 'conditional', 'lte IE 7');
              $wp_styles->enqueue(array($handle));
              */
            //wp_enqueue_style($handle);
              //global $wp_styles;
                //$wp_styles->add_data( $handle, 'property', 'stylesheet' );
        }
  }

public function printScryptfront($handle, $path)
  {
  $currScryptFile = plugin_dir_path( __FILE__ )."/../".$path;
    $currScryptUrl = plugins_url("/../".$path, __FILE__);

        if ( file_exists($currScryptFile) ) {

              wp_localize_script($handle, 'subitem_al_WPURLS', array( 'pluginurl' => trailingslashit( plugin_dir_url( __FILE__ ) ) ));
            wp_print_scripts($handle);
        }

  }
}
?>