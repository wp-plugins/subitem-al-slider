<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Controller_Items extends Sial_Controller{
private $model_items;

public function __construct($model_items)
  {
  parent::__construct();
    $this->model_items = $model_items;
  }
public function saveItemData_ajax()
  {
   if (isset($_POST['item_save_ajax']))
    {
      $this->check_ajax('upd_rec_item', 'nonce');
      
      $id = $this->model_items->insItemData($_POST);
      
      echo $id;
    }
   exit(); 
  }
public function delItemData_ajax()
  {
  if (isset($_POST['item_del_ajax']))
    {
      $this->check_ajax('upd_rec_item', 'nonce');
      
      $this->model_items->delItemInfo($_POST['itemid']);
      
      echo "1";
    }
   exit();
  }

public function execute($pid)
  {
  //Ajax request

  return array();
  }
}
?>