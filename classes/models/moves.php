<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Model_Moves extends Model{
private $table;
public function __construct($db)
  {
  parent::__construct($db);
    $this->table = $this->db->wpdb->prefix."sial_moves";
  }
public function saveMoveData($source_out, $id)
  {
  if (isset($source_out['single'])&&(!empty($source_out['single'])))
   {
  $movepoints_model = new Model_MovePoints($this->db);
  $names = array();
  $source = $source_out['single'];
  foreach ($source as $name=>$src)
    {
      $names[] = $name;
    }

    $src = array();
  for ($i=0;$i<=count($source['name'])-1;$i++)
    {
    foreach ($names as $nm)
      {
      if ((isset($source[$nm]))&&(isset($source[$nm][$i])))
        $src[$nm] = $source[$nm][$i];
      }
      $src['num'] = $i;
  $filter = array(array('source', 'source', '%d'),array('name', 'name', '%s'), array('url', 'url', '%s'), 
            array('start_delay', 'start_delay', '%d'),
            array('start_size', 'start_size', '%d'),
            array('start_opacityin', 'start_opacityin', '%d'), array('start_opacityout', 'start_opacityout', '%d'),
            array('start_posxin', 'start_posxin', '%d'), array('start_posyin', 'start_posyin', '%d'),
            array('start_posxout', 'start_posxout', '%d'), array('start_posyout', 'start_posyout', '%d'),
            array('start_duration', 'start_duration', '%d'), array('start_easing', 'start_easing', '%s'),
            array('start_method', 'start_method', '%s'),
            array('start_rotation', 'start_rotation', '%d'), array('start_rotation_out', 'start_rotation_out', '%d'),
             array('start_rotation_origin', 'start_rotation_origin', '%s'),
            array('start_rotation3d', 'start_rotation3d', '%s'), array('start_rotation3d_out', 'start_rotation3d_out', '%s'),
            array('start_scale3d', 'start_scale3d', '%s'), array('start_scale3d_out', 'start_scale3d_out', '%s'),
            array('start_translate3d', 'start_translate3d', '%s'), array('start_translate3d_out', 'start_translate3d_out', '%s'),
            array('start_transform3d_origin', 'start_transform3d_origin', '%s'),
            array('start_transform_method', 'start_transform_method', '%d'),
            
            array('finish_size', 'finish_size', '%d'), array('finish_opacity', 'finish_opacity', '%d'),
            array('finish_posxin', 'finish_posxin', '%d'), array('finish_posyin', 'finish_posyin', '%d'),
            array('finish_posxout', 'finish_posxout', '%d'), array('finish_posyout', 'finish_posyout', '%d'),
            array('finish_duration', 'finish_duration', '%d'), array('finish_easing', 'finish_easing', '%s'),
            array('finish_method', 'finish_method', '%s'),
            array('finish_rotation', 'finish_rotation', '%d'), array('finish_rotation_origin', 'finish_rotation_origin', '%s'),
            array('finish_rotation3d', 'finish_rotation3d', '%s'), array('finish_scale3d', 'finish_scale3d', '%s'),
            array('finish_translate3d', 'finish_translate3d', '%s'),
            array('finish_transform3d_origin', 'finish_transform3d_origin', '%s'),
            array('finish_transform_method', 'finish_transform_method', '%d'),
                        
            array('width', 'width', '%d'), array('height', 'height', '%d'),
            array('font_size', 'font_size', '%d'), array('num', 'num', '%d'),
            );
  if (!intval(sanitize_text_field($src['moveid'])))return false;
  $idval = array('id' => intval(sanitize_text_field($src['moveid'])));
  $idtype = array('%d');
      $this->db->saveData($this->table, $src, $filter, 'update', $idval, $idtype);

    }
    if (isset($source['move_point']))
      $movepoints_model->saveMovePointsAll($source['move_point']);
    
   return true;
   }
   return false;
  }
public function insMoveRow($source)
  {
  $src = array('name'=>'','url'=>'','id_selector'=>'.mv_'.uniqid(),'id_parent_selector'=>'.subitem_al_wrapper_slider',
  'start_easing'=>'swing', 'start_method'=>'left_right', 'finish_easing'=>'swing', 'finish_method'=>'left_right');
  $src['id_container'] = $source['id_container'];
  $src['source'] = $source['source'];
  
  $filter = array(array('source', 'source', '%d'),array('name', 'name', '%s'), array('url', 'url', '%s'), 
            array('id_selector', 'id_selector', '%s'), array('id_parent_selector', 'id_parent_selector', '%s'),
            array('start_easing', 'start_easing', '%s'), array('start_method', 'start_method', '%s'),
            array('finish_easing', 'finish_easing', '%s'), array('finish_method', 'finish_method', '%s'),
            array('id_container', 'id_container', '%s'),
            );

  $id = $this->db->saveData($this->table, $src, $filter, 'insert');
  
   return $id;
  }
public function getMoveInfo($id)
  {
  $conttable = $this->db->wpdb->prefix."sial_containers";
  $move_points_table = $this->db->wpdb->prefix."sial_move_points";
  $sql = "select '' as mvdummy, mv.id as mvid,mv.*,'' as ctdummy, ct.*,'' as mptdummy, mpt.*, mpt.id as mptid, mpt.duration as mptduration from " . $this->table . " as mv left join " . $conttable . " as ct on (mv.id_container = ct.id) left join " . $move_points_table . " as mpt on (mpt.id_move = mv.id)  where ct.id_main=%d order by mv.num, mpt.num asc";
    $params = array($id,);
    return $this->db->fetchData($sql, $params);
  }
public function delMoveInfo($id)
  {
  $tables = array('move_points'=>$this->db->wpdb->prefix."sial_move_points");

  $params = array($id);
  $sql = "delete moves.*, move_points.* from ".$this->table." as moves left join ".$tables['move_points']." as move_points on (moves.id=move_points.id_move) where moves.id=%d";

    $this->db->generalSql($sql, $params);

    return true;
  }

}
?>