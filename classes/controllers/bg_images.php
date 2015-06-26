<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Controller_BgImages extends Sial_Controller{
private $model_bgimages;

public function __construct($model_bgimages)
  {
  parent::__construct();
    $this->model_bgimages = $model_bgimages;
  }

public function saveBgData()
  {
   if (isset($_POST['bg_save_btn']))
    {
      $this->check('sp_bg_image');
      
      $this->model_bgimages->saveBgData($_POST, $_POST['bgid']);
      
      return $_POST['bgid'];
    }
   return false; 
  }
public function saveBgData_ajax()
  {
   if (isset($_POST['bg_save_ajax']))
    {
      $this->check_ajax('upd_rec', 'nonce');
      
      $id = $this->model_bgimages->insBgData($_POST);
      
      echo $id;
    }
   exit(); 
  }
public function getBgData($id)
  {
      return $this->model_bgimages->getBgInfo($id);
  }
public function delBgData()
  {
  if (isset($_POST['bg_del_btn']))
    {
      $this->check('sp_bg_image');
      
      return $this->model_bgimages->delBgInfo($_POST['bgid']);
    }
   return false;
  }
public function massActBgData()
  {
   if (isset($_POST['mass_execution_btn']))
    {
      $this->check('sp_bg_image_delete_mass');
      
          switch ($_POST['mass_action'])
          {
          case '1' : $this->model_bgimages->massDelBgData($_POST['chk_now']); break;
          }

      return true;
     }
   return false;
  }
public function execute($pid)
  {
  //Ajax request
    
  //Delete background image
    $this->delBgData();
        
  //Mass action bg images
    $this->massActBgData();
        
  //Save background image
    $bgid = $this->saveBgData();

  //Load backgrounds
    $bg_info = $this->getBgData($pid);

  return array($bgid, $bg_info);
  }
}
?>