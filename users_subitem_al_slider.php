<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Sial_Users extends Sial_Base{

public static function subitem_al_slider($atts)
  {
  global $subitemal_adding_scripts;
  $subitemal_adding_scripts = true;

  $front = new Sial_Users_Common();
    return $front->execute($atts['id']);
  }
public function current_url_handler()
  {
    if(!empty($_SERVER['REQUEST_URI']))
    {
        $urlvars_string = explode('?', $_SERVER['REQUEST_URI']);
    }
     
     $urlvars = explode("&", $urlvars_string[1]);

    if((!empty($urlvars[0])) && (!empty($urlvars[1])) && (!empty($urlvars[2])))
    {
        $_REQUEST['myview'] = sanitize_text_field($urlvars[0]);
         
        if($urlvars[0] == 'image')
        {
            $_REQUEST['mynonce'] = sanitize_text_field($urlvars[1]);
            $_REQUEST['myfile'] = $urlvars[2];
             
            add_action('template_redirect', array('\subitemal\Sial_Image', 'image_handler'));
        }
         
    }
  }
}
?>