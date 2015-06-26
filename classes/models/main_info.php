<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Model_MainInfo extends Model{
private $table;
public function __construct($db)
  {
  parent::__construct($db);
    $this->table = $this->db->wpdb->prefix."sial_main_info";
  }
public function saveMainData($source, $pid)
  {
  if (!isset($source['fullscreen'])) $source['fullscreen'] = 0;
    if (!isset($source['fullwidth']))  $source['fullwidth'] = 0;
      if (!isset($source['slide_processing']))  $source['slide_processing'] = 0;

  if (isset($source['effects_names']))
  $source['effects_names_gather'] = implode("***", $source['effects_names']);
    else
  $source['effects_names_gather'] = 'default';

  $filter = array(array('width', 'width', '%d'), array('height', 'height', '%d'), array('halign', 'halign', '%d'),
            array('valign', 'valign', '%d'), array('activewidth', 'activewidth', '%d'), array('activeheight', 'activeheight', '%d'),
            array('activeoffsetleft', 'activeoffsetleft', '%d'), array('activeoffsettop', 'activeoffsettop', '%d'),
            array('effect', 'effects_names_gather', '%s'), 
            array('fullscreen', 'fullscreen', '%d'),
            array('fullwidth', 'fullwidth', '%d'),
            array('slide_processing', 'slide_processing', '%d'),
            array('duration', 'duration', '%d'),
            array('name', 'name', '%s'),
            array('duration_effect', 'duration_effect', '%d'), array('apply_classes', 'apply_classes', '%s', 'not'),
            array('effect_direction', 'effect_direction', '%s')
            );
  if (!intval(sanitize_text_field($pid)))return false;
  
  $idval = array('id' => intval(sanitize_text_field($pid)));
  $idtype = array('%d');
  
   return $this->db->saveData($this->table, $source, $filter, 'update', $idval, $idtype);
  }
public function saveSettingsButtons($source, $pid)
  {
  $filter = array(array('settings_buttons', 'settings_buttons', '%d'),
   array('settings_buttons_width', 'settings_buttons_width', '%d'),
   array('settings_buttons_opacity', 'settings_buttons_opacity', '%d'),
   array('settings_buttons_top', 'settings_buttons_top', '%d')
   );
  if (!intval(sanitize_text_field($pid)))return false;
  
  $idval = array('id' => intval(sanitize_text_field($pid)));
  $idtype = array('%d');
  
   return $this->db->saveData($this->table, $source, $filter, 'update', $idval, $idtype);
  }

public function saveSettingsIndicators($source, $pid)
  {
  $filter = array(array('settings_indicators', 'settings_indicators', '%d'),
   array('settings_indicators_top', 'settings_indicators_top', '%d'),
   array('settings_indicators_width', 'settings_indicators_width', '%d'),
   array('settings_num_indicators', 'settings_num_indicators', '%d'));
   
  if (!intval(sanitize_text_field($pid)))return false;
  
  $idval = array('id' => intval(sanitize_text_field($pid)));
  $idtype = array('%d');
  
   return $this->db->saveData($this->table, $source, $filter, 'update', $idval, $idtype);
  }

public function createProject($name)
  {
  $name = sanitize_text_field($name);
    if (!$name) return false;
  
    $rowId = $this->db->insertRow($this->table,
                                  array('name' => $name, 'width' => 0, 'height' => 0, 'halign' => 0, 'valign' => 0,
                                   'activewidth' => 0, 'activeheight' => 0, 'activeoffsetleft' => 0, 'activeoffsettop' => 0,
                                   'effect' => 'default', 'effect_direction' => 'forward'),
                                  array('%s', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%s')
                                  );
    return $rowId;
  }
public function getProjects()
  {
    return $this->db->fetchAll($this->table, " name, id ");
  }
public function getMainInfo($id)
  {
    return $this->db->fetchByVal($this->table, "id", $id, '%d');
  }
public function delMainInfo($id)
  {
  $tables = array('bg_imgs'=>$this->db->wpdb->prefix."sial_bg_images", 'cont'=>$this->db->wpdb->prefix."sial_containers",
                  'imgs'=>$this->db->wpdb->prefix."sial_images", 'txts'=>$this->db->wpdb->prefix."sial_texts",
                  'grps'=>$this->db->wpdb->prefix."sial_groups",
                  'items'=>$this->db->wpdb->prefix."sial_items", 'moves'=>$this->db->wpdb->prefix."sial_moves",
                  'move_points'=>$this->db->wpdb->prefix."sial_move_points");

  $params = array($id);
  $sql = "delete main.*, cont.*, bg_imgs.*, items.*, moves.*, move_points.*, txts.*, imgs.*, grps.*  from ".$this->table." as main left join ".$tables['bg_imgs']." as bg_imgs on (main.id=bg_imgs.id_main) left join ".$tables['cont']." as cont on (cont.id_main=main.id) left join ".$tables['items']." as items on (cont.id=items.id_container) left join ".$tables['moves']." as moves on (cont.id=moves.id_container) left join ".$tables['move_points']." as move_points on (moves.id=move_points.id_move) left join ".$tables['txts']." as txts on (txts.id_main=main.id) left join ".$tables['imgs']." as imgs on (imgs.id_main=main.id) left join ".$tables['grps']." as grps on (grps.id_main=main.id) where main.id=%d";

    $this->db->generalSql($sql, $params);

    return true;
  }
}
?>