<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Sial_Users_Common extends Sial_Base{
public function __construct()
  {
  if (method_exists(get_parent_class(), '__construct'))
      parent::__construct();
      
  }
public function execute($id)
  {
  $data = array();
  $db = new Sial_CacheDb();
    $mainController = new Controller_Main(new Model_Main($db));
      $data['front'] = $mainController->execute($id);

    $views = new Sial_View(array('front/block1_header', array('front/block1'), 'front/block1_footer'));
    $views->setData($data);
    return $views->viewTemplates();
  }
}