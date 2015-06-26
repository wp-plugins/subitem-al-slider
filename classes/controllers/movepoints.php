<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Controller_MovePoints extends Sial_Controller{
private $model_movepoints;

public function __construct($model_movepoints)
  {
  parent::__construct();
    $this->model_movepoints = $model_movepoints;
  }

public function saveMovePointData()
  {
      $this->model_movepoints->saveMovePointData($_POST, $_POST['containerid']);
   return false; 
  }
public function saveMovePointData_ajax()
  {
   if (isset($_POST['movepoint_save_ajax']))
    {
      $this->check_ajax('upd_rec_move', 'nonce');
      
      $id = $this->model_movepoints->insMovePointRow($_POST);
      
      echo $id;
    }
   exit();
  }
public function getMovePointData($id)
  {
      return $this->filter_moves($this->model_movepoints->getMovePointInfo($id));
  }
public function filter_moves($source)
  {
  $res = array();
  foreach ($source as $src)
    {
    if (isset($res[$src->id_container]))
          $res[$src->id_container][] = $src;
          else
          {
          $res[$src->id_container] = array();
            $res[$src->id_container][] = $src;
          }
    }
   return $res;
  }
public function delMovePointData_ajax()
  {
  if (isset($_POST['movepoint_del_ajax']))
    {
      $this->check_ajax('upd_rec_move', 'nonce');
      
      if ($this->model_movepoints->delMovePointInfo($_POST['id']))
        echo 1;
    }
   exit();
  }

public function execute($pid)
  {

  //Save MovePoint item
    $movepointid = '';

  //Load MovePoint items
    $movepoint_info = '';

  return array($movepointid, $movepoint_info);
  }

}
?>