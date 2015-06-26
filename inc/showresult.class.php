<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Sial_ShowResult extends Sial_Base{

public function __construct()
  {
  if (method_exists(get_parent_class(), '__construct'))
      parent::__construct();
  }
public function showresult_handler()
  {
  ob_start();
    get_header();
      $content = ob_get_contents();
  ob_end_clean();
      echo $content;
  $this->scrypts_out($content);
      $this->main_out($_REQUEST['myproject'], $_REQUEST['myslide']);
  get_footer();
  exit();
  }
public function scrypts_out($content)
  {
  if (strpos($content, 'jquery.insidergall.js') === FALSE)
    {
      //Controller_Main::add_scripts_slide_fronend();
      do_action("wp_enqueue_scripts");
    }
  }
public function main_out($proj_id, $container_id)
  {
  $data = array();
  $data['container_show_id'] = $container_id;
  $db = new Sial_CacheDb();
    $mainController = new Controller_Main(new Model_Main($db));
      $data['front'] = $mainController->execute($proj_id);

    $views = new Sial_View(array('slide/block1_header', array('slide/block1'), 'slide/block1_footer'));
    $views->setData($data);
    echo $views->viewTemplates();
  }
}
?>