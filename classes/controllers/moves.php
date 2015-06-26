<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Controller_Moves extends Sial_Controller{
private $model_moves;

public function __construct($model_moves)
  {
  parent::__construct();
    $this->model_moves = $model_moves;
  }

public function saveMoveData_ajax()
  {
   if (isset($_POST['move_save_ajax']))
    {
      $this->check_ajax('upd_rec_move', 'nonce');
      
      $id = $this->model_moves->insMoveRow($_POST);
      
      echo $id;
    }
   exit();
  }
public function getMoveData($id)
  {
      $mvs = $this->filter_moves($this->model_moves->getMoveInfo($id));

      return $mvs;
  }
public function filter_moves($source)
  {
  $res = array();

  foreach ($source as $src)
    {
    $fl = false;
    $move_point = array();
    foreach ($src as $key=>$elem)
      {
        if ($fl)
            $move_point[$key] = $elem;
        if ($key == "mptdummy")
          $fl = true;
      }
        

      
    if (isset($res[$src->id_container]))
          $res[$src->id_container][$src->mvid]['main'] = $src;
          else
          {
          $res[$src->id_container] = array();
          $res[$src->id_container][$src->mvid] = array();
            $res[$src->id_container][$src->mvid]['main'] = $src;
          }
          
    if (is_array($res[$src->id_container][$src->mvid]))
       $res[$src->id_container][$src->mvid]['mp'][] = $move_point;
       else
       {
       $res[$src->id_container][$src->mvid]['mp'] = array();
       $res[$src->id_container][$src->mvid]['mp'][] = $move_point;
       }
    }

   return $res;
  }
public function delMoveRow_ajax()
  {
  if (isset($_POST['move_del_ajax']))
    {
      $this->check_ajax('upd_rec_move', 'nonce');
      
      if ($this->model_moves->delMoveInfo($_POST['id']))
        echo 1;
    }
   exit();
  }

public function execute($pid)
  {
  //Load move data
    $move_info = $this->getMoveData($pid);
  //Empty $moveid
  $moveid = "";

  return array($moveid, $move_info);
  }

}
?>