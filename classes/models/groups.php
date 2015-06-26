<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Model_Groups extends Model{
private $table;
public function __construct($db)
  {
  parent::__construct($db);
    $this->table = $this->db->wpdb->prefix."sial_groups";
  }
public function updGroupData($source, $id)
  {
  $filter = array(array('name', 'group_name', '%s'));
  if (!intval(sanitize_text_field($id)))return false;
  
  $idval = array('id' => intval(sanitize_text_field($id)));
  $idtype = array('%d');
  
   return $this->db->saveData($this->table, $source, $filter, 'update', $idval, $idtype);
  }
public function addGroupData($source)
  {
  $filter = array(array('name', 'group_name', '%s'), array('id_main', 'id_main', '%d'));

   return $this->db->saveData($this->table, $source, $filter, 'insert', null, null);
  }
public function getGroupInfo($id)
  {
    return $this->db->fetchByVal($this->table, "id_main", $id, '%d');
  }
public function delGroupData($id)
  {
    return $this->db->deleteRow($this->table, "id", $id, '%d');
  }
public function getGroupFirst()
  {
    return $this->db->fetchFirst($this->table);
  }

//Dump
public function massDelBgData($chk_ids)
  {
    return $this->db->massDeleteRows($this->table, 'id', $chk_ids);
  }

}
?>