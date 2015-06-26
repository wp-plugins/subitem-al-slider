<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Sial_Admin extends Sial_Base{
private $currentDir;
private $file;

public function __construct($file)
  {
  $this->file = $file;
  $filePath = $file;
    $this->currentDir = dirname($filePath);

    $this->activite();
  add_action('init', array($this, 'init'));
    add_action('after_setup_theme', array($this, 'slide_handler'));
       add_action( 'widgets_init', array($this, 'register_slider_widget') );
       
    $adminCommon = new Sial_Admin_Common($this->file);
     add_action( 'plugins_loaded', array($adminCommon, 'sial_al_update_db_check' ));
  }
public function init()
  {
    $adminCommon = new Sial_Admin_Common($this->file);
        $adminCommon->init();
  }
public function activite()
  {
      Sial_Admin_Common::onActivate($this->file);
  }
public function slide_handler()
  {
if(!empty($_SERVER['REQUEST_URI']))
    {
        $urlvars_string = explode('?', $_SERVER['REQUEST_URI']);
    }
    else
    return;
    
    if (!isset($urlvars_string[1]))return;
    
     $urlvars = explode("&", $urlvars_string[1]);

    if((!empty($urlvars[0])) && (!empty($urlvars[1])) && (!empty($urlvars[2])) && (!empty($urlvars[3])))
    {
        $_REQUEST['myview'] = sanitize_text_field($urlvars[0]);
         
        if($urlvars[0] == 'subitem_al_slide')
        {
            $mynonce = sanitize_text_field($urlvars[1]);
              $_REQUEST['myproject'] = sanitize_text_field($urlvars[2]);
                $_REQUEST['myslide'] = sanitize_text_field($urlvars[3]);

           if ( ! wp_verify_nonce( $mynonce, 'slide_url' ) ) {
            die( 'Security check did not passed' ); 
            } else {
            add_action( 'wp_enqueue_scripts', array('\subitemal\Controller_Main', 'add_scripts_fronend' ));
                //add_action('init', array('\subitemal\Controller_Main', 'register_scripts_fronend' ));
                //add_action('wp_footer', array('\subitemal\Controller_Main', 'print_scripts_fronend' ));

            $show = new Sial_ShowResult();
              //$show->showresult_handler();
              add_action( 'wp_loaded', array($show, 'showresult_handler' ));
            }

        }
         
    }
  }
}
?>