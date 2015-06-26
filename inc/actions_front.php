<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

           //Add script to front end
    add_action('init', array('\subitemal\Controller_Main', 'register_scripts_fronend' ));
    add_action('wp_footer', array('\subitemal\Controller_Main', 'print_scripts_fronend' ));
    
          //Register Widget for front end
    add_action( 'widgets_init', array('\subitemal\Sial_Users', 'register_slider_widget') );

    
?>