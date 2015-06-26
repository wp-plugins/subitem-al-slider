<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Model_Containers extends Model{
private $table;
public function __construct($db)
  {
  parent::__construct($db);
    $this->table = $this->db->wpdb->prefix."sial_containers";
  }
public function saveContainerData($source, $id, $items)
  {
  $model_items = new Model_Items($this->db);
      $model_moves = new Model_Moves($this->db);
      
  if (isset($items)&&(!empty($items)))
    $model_items->saveAllItems($items, $id);

    $model_moves->saveMoveData($_POST, $_POST['containerid']);
  
  $filter = array(array('id_bg_image', 'choose_bg', '%d'), array('id_main', 'pid', '%d'), array('effect', 'choose_effect', '%s'),
            array('effect_direction', 'effect_direction', '%s'), array('duration', 'duration', '%d'), 
            array('duration_effect_inner', 'duration_effect', '%d'), 
            array('offset_left_inner', 'offset_left_inner', '%d'), array('offset_top_inner', 'offset_top_inner', '%d')
            );
  if (!intval(sanitize_text_field($id)))return false;
  
  $idval = array('id' => intval(sanitize_text_field($id)));
  $idtype = array('%d');
  
   return $this->db->saveData($this->table, $source, $filter, 'update', $idval, $idtype);
  }
public function insContainerData($source)
  {
  $model_bgimages = new Model_BgImages($this->db);
  $bgs = $model_bgimages->getBgInfoFirst();
    $source['id_bg_image'] = $bgs[0]->id;
  
  $filter = array(array('id_bg_image', 'id_bg_image', '%d'), array('id_main', 'id_main', '%d'), array('effect', 'effect', '%s'),
            array('effect_direction', 'effect_direction', '%s'), array('num', 'num', '%d')
            );

   return $this->db->saveData($this->table, $source, $filter, 'insert');
  }
public function updPositionsData($ids)
  {
  $item_elem = array();
  foreach ($ids as $key=>$id)
    {
        $swp = array('id'=>$id, 'num'=>intval(sanitize_text_field($key)));
      $item_elem[] = $swp;
    }
    if ($this->saveBulkPositions($item_elem))
      return "1";
      else
      return "0";
  }
public function saveBulkPositions($source)
  {
$sql = "UPDATE ".$this->table." im
          JOIN ( ";
$last_key = end(array_keys($source));

  foreach ($source as $key=>$src)
   {
   $sql .= "SELECT ". esc_sql(sanitize_text_field($src['id']))." as _id,
      ". esc_sql(sanitize_text_field($src['num']))." as _num";

    if ($last_key != $key)
        $sql .= " UNION ALL ";
   }
$sql .= ") vals ON im.id = vals._id
        SET num = _num";

        $this->db->generalSqlWp($sql);
    return true;
  }

public function getContainerInfo($id)
  {
  $table_items = $this->db->wpdb->prefix."sial_items";
  $src = "select *, tc.id as tcid , tc.num as tcnum ,ti.id as tiid, ti.num as tinum  from ".$this->table." as tc
          left join $table_items as ti on (tc.id=ti.id_container)  where tc.id_main=%d order by tc.num asc,ti.num asc, tc.id asc";

    return $this->db->fetchData($src, array($id));
  }
public function delContainerInfo($id)
  {
  $tables = array('items'=>$this->db->wpdb->prefix."sial_items", 'moves'=>$this->db->wpdb->prefix."sial_moves",
                  'move_points'=>$this->db->wpdb->prefix."sial_move_points");

  $params = array($id);
  $sql = "delete cont.*, items.*, moves.*, move_points.* from ".$this->table." as cont left join ".$tables['items']." as items on (cont.id=items.id_container) left join ".$tables['moves']." as moves on (cont.id=moves.id_container) left join ".$tables['move_points']." as move_points on (moves.id=move_points.id_move) where cont.id=%d";

    $this->db->generalSql($sql, $params);

    return true;
  }
public function massDelContainerData($chk_ids)
  {
  foreach ($chk_ids as $id)
    {
      $this->delContainerInfo($id);
    }
    return true;
  }

}
?>