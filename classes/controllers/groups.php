<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Controller_Groups extends Sial_Controller{
private $model_groups;

public function __construct($model_groups)
  {
  parent::__construct();
    $this->model_groups = $model_groups;
  }

public function addGroupData()
  {
   if (isset($_POST['add_group_btn']))
    {
      $this->check('groups');

      $groupid = $this->model_groups->addGroupData($_POST);
      
      return $groupid;
    }
   return false; 
  }
public function updGroupData()
  {
   if (isset($_POST['upd_group_btn']))
    {
      $this->check('groups');

      $this->model_groups->updGroupData($_POST, $_POST['upd_group_btn']);
      
      return $_POST['upd_group_btn'];
    }
   return false; 
  }
public function delGroupData()
  {
   if (isset($_POST['del_group_btn']))
    {
      $this->check('groups');

      $this->model_groups->delGroupData($_POST['del_group_btn']);
      
      return true;
    }
   return false; 
  }

public function getGroupData($id)
  {
      $groups = $this->model_groups->getGroupInfo($id);
    return $groups;
  }
  
public function execute($pid)
  {
  //Delete group
    $this->delGroupData();

  //Update group
    $this->updGroupData();
        
  //Mass action containers
   // $this->massActContainerData();
        
  //add group
    $groupid = $this->addGroupData();

  //Load containers
    $group_info = $this->getGroupData($pid);

  return array($groupid, $group_info);
  }

}
?>