<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Controller_Containers extends Sial_Controller{
private $model_containers;

public function __construct($model_containers)
  {
  parent::__construct();
    $this->model_containers = $model_containers;
  }

public function saveContainerData()
  {
   if (isset($_POST['container_save_btn']))
    {
      $this->check('sp_container');

  (isset($_POST['item_selectbox'])) ? $swp = $_POST['item_selectbox'] : $swp = "";
      $this->model_containers->saveContainerData($_POST, $_POST['containerid'], $swp);
      
      return $_POST['containerid'];
    }
   return false; 
  }
public function saveContainerData_ajax()
  {
   if (isset($_POST['container_save_ajax']))
    {
      $this->check_ajax('upd_rec_container', 'nonce');

      $id = $this->model_containers->insContainerData($_POST);
      
      echo $id;
    }
   exit(); 
  }
public function saveContainersPositions_ajax()
  {
   if (isset($_POST['container_pos_ajax']))
    {
      $this->check_ajax('upd_rec_container', 'nonce');

      $result = $this->model_containers->updPositionsData($_POST['contid']);
      
      echo $result;
    }
   exit(); 
  }

public function getContainerData($id)
  {
      $containers = $this->model_containers->getContainerInfo($id);
      $containers_info = $this->filter_container($containers);

      
    return $containers_info;
  }
function filter_container($containers_info)
  {
  $old_containers = array();
    $result = array();
    $swp = array();
    
  foreach ($containers_info as $container)
    {
      if (!in_array($container->tcid, $old_containers))
        {
          $result[$container->tcid] = (object)array('id'=>$container->tcid,
                              'id_bg_image'=>$container->id_bg_image, 
                              'id_main'=>$container->id_main,
                              'effect'=>$container->effect,
                              'effect_direction'=>$container->effect_direction,
                              'num'=>$container->tcnum,
                              'duration'=>$container->duration,
                              'duration_effect_inner'=>$container->duration_effect_inner,
                              'offset_left_inner'=>$container->offset_left_inner,
                              'offset_top_inner'=>$container->offset_top_inner,
                              'items'=>array()
                              );

          $result[$container->tcid]->items[] = array('id'=>$container->tiid,
                                  'id_container'=>$container->id_container,
                                  'id_group'=>$container->id_group,
                                  'type'=>$container->type,
                                  'num'=>$container->tinum
                                  );
          $old_containers[] = $container->tcid;

        }
        else
        {
          $result[$container->id_container]->items[] = array('id'=>$container->tiid,
                                  'id_container'=>$container->id_container,
                                  'id_group'=>$container->id_group,
                                  'type'=>$container->type,
                                  'num'=>$container->tinum
                                  );
        }

    }
    return $result;
  }

  
public function delContainerData()
  {
  if (isset($_POST['container_del_btn']))
    {
      $this->check('sp_container');
      
      return $this->model_containers->delContainerInfo($_POST['containerid']);
    }
   return false;
  }
  

public function execute($pid)
  {
  //Ajax request

  //Delete container
    $this->delContainerData();
        
  //Mass action containers
   // $this->massActContainerData();
        
  //Save container
    $containerid = $this->saveContainerData();

  //Load containers
    $container_info = $this->getContainerData($pid);

  return array($containerid, $container_info);
  }

}
?>