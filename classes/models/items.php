<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Model_Items extends Model{
private $table;
public function __construct($db)
  {
  parent::__construct($db);
    $this->table = $this->db->wpdb->prefix."sial_items";
  }

public function saveAllItems($items, $id)
  {
 $item_elem = array();
  foreach ($items as $item)
    {
      $arr = explode(":", sanitize_text_field($item));
        $swp = array('id'=>$arr[0], 'id_container'=>intval(sanitize_text_field($id)), 'id_group'=>$arr[1],
                                                'type'=>1, 'num'=>$arr[2]);
      $item_elem[] = $swp;
    }
    $this->saveBulkData($item_elem);
  }
public function saveBulkData($source)
  {
$sql = "UPDATE ".$this->table." im
          JOIN ( ";

$last_key_arr = array_keys($source);
$last_key = end($last_key_arr);

  foreach ($source as $key=>$src)
   {
   $sql .= "SELECT ". esc_sql(sanitize_text_field($src['id']))." as _id,
      ". esc_sql(sanitize_text_field($src['id_container']))." as _id_container,
        ". esc_sql(sanitize_text_field($src['id_group']))." as _id_group,
          ". esc_sql(sanitize_text_field($src['type']))." as _type, 
            ". esc_sql(sanitize_text_field($src['num']))." as _num";

    if ($last_key != $key)
        $sql .= " UNION ALL ";
   }
$sql .= ") vals ON im.id = vals._id
        SET id_container = _id_container, id_group = _id_group, type = _type, num = _num";

        $this->db->generalSqlWp($sql);
    return true;
  }
public function saveItemData($source, $id)
  {
  $filter = array(array('id_container', 'id_container', '%d'), array('id_group', 'id_group', '%d'), array('type', 'type', '%s'),
            array('num', 'num', '%d')
            );
  if (!intval(sanitize_text_field($id)))return false;
  
  $idval = array('id' => intval(sanitize_text_field($id)));
  $idtype = array('%d');
  
   return $this->db->saveData($this->table, $source, $filter, 'update', $idval, $idtype);
  }
public function insItemData($source)
  {
  $model_groups = new Model_Groups($this->db);
  $fgroup = $model_groups->getGroupFirst();
    $source['id_group'] = $fgroup[0]->id;
  
  $filter = array(array('id_container', 'id_container', '%d'), array('id_group', 'id_group', '%d'), array('type', 'type', '%s'),
            array('num', 'num', '%d')
            );

   return $this->db->saveData($this->table, $source, $filter, 'insert');
  }
//Dump
public function getItemInfo($id)
  {
    return $this->db->fetchByVal($this->table, "id_main", $id, '%d');
  }
//Dump
public function delItemInfo($id)
  {
    return $this->db->deleteRow($this->table, "id", $id, '%d');
  }
//Dump
public function massDelItemData($chk_ids)
  {
    return $this->db->massDeleteRows($this->table, 'id', $chk_ids);
  }

}
?>