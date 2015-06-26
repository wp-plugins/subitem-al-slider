<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Model_MovePoints extends Model{
private $table;
public function __construct($db)
  {
  parent::__construct($db);
    $this->table = $this->db->wpdb->prefix."sial_move_points";
  }
public function saveMovePointsAll($source)
  {

  $sql = "UPDATE ".$this->table." im JOIN ( ";
  $sql2 = "UPDATE ".$this->table." im JOIN ( ";
    $num_delay = 0;
    $num_move = 0;
    
      for ($i=0;$i<=count($source['method'])-1;$i++)
      {
        switch ($source['method'][$i])
        {
          case 'delay_point' : 
             $sql .= "SELECT ". esc_sql(sanitize_text_field($source['id'][$i]))." as _id,
              '". esc_sql(sanitize_text_field($source['method'][$i]))."' as _method,
              ". esc_sql(sanitize_text_field($source['duration'][$i]))." as _duration,
              ". esc_sql(sanitize_text_field($i))." as _num";
             $sql .= " UNION ALL ";
             $num_delay++;
             break;
          case 'move_point' : 
             $sql2 .= "SELECT ". esc_sql(sanitize_text_field($source['id'][$i]))." as _id,
              ". esc_sql(sanitize_text_field($source['size'][$i]))." as _size,
              ". esc_sql(sanitize_text_field($source['opacity'][$i]))." as _opacity,
              ". esc_sql(sanitize_text_field($source['posx'][$i]))." as _posx,
              ". esc_sql(sanitize_text_field($source['posy'][$i]))." as _posy,
              ". esc_sql(sanitize_text_field($source['posxout'][$i]))." as _posxout,
              ". esc_sql(sanitize_text_field($source['posyout'][$i]))." as _posyout,
              ". esc_sql(sanitize_text_field($source['duration'][$i]))." as _duration,
              '". esc_sql(sanitize_text_field($source['easing'][$i]))."' as _easing,
              '". esc_sql(sanitize_text_field($source['method'][$i]))."' as _method,
              ". esc_sql(sanitize_text_field($source['rotation'][$i]))." as _rotation,
              '". esc_sql(sanitize_text_field($source['rotation3d'][$i]))."' as _rotation3d,
              '". esc_sql(sanitize_text_field($source['scale3d'][$i]))."' as _scale3d,
              '". esc_sql(sanitize_text_field($source['translate3d'][$i]))."' as _translate3d,
              '". esc_sql(sanitize_text_field($source['rotation_origin'][$i]))."' as _rotation_origin,
              '". esc_sql(sanitize_text_field($source['transform3d_origin'][$i]))."' as _transform3d_origin,
              ". esc_sql(sanitize_text_field($source['transform_method'][$i]))." as _transform_method,
              ". esc_sql(sanitize_text_field($i))." as _num";
             $sql2 .= " UNION ALL ";
             $num_move++;
             break;
        }
      }
      $sql = substr($sql, 0, strlen($sql)-10);
      $sql2 = substr($sql2, 0, strlen($sql2)-10);
$sql .= ") vals ON im.id = vals._id
        SET method = _method, duration = _duration, num = _num";

$sql2 .= ") vals ON im.id = vals._id
        SET size = _size, opacity = _opacity, posx = _posx, posy = _posy, posxout = _posxout
        , posyout = _posyout, duration = _duration, easing = _easing, method = _method, rotation = _rotation,
        rotation3d = _rotation3d, scale3d = _scale3d, translate3d = _translate3d, transform_method = _transform_method
        , rotation_origin = _rotation_origin, transform3d_origin = _transform3d_origin, num = _num";
        
        if ($num_delay>0)
        $this->db->generalSqlWp($sql);
        if ($num_move>0)
        $this->db->generalSqlWp($sql2);
  }
public function insMovePointRow($source)
  {
  $filter = array(array('id_move', 'id_move', '%d'), array('method', 'method', '%s'));

  $id = $this->db->saveData($this->table, $source, $filter, 'insert');
  
   return $id;
  }
public function getMovePointInfo($id)
  {
  $conttable = $this->db->wpdb->prefix."sial_containers";
  $sql = "select mv.id as mvid,mv.*,ct.* from " . $this->table . " as mv left join " . $conttable . " as ct on (mv.id_container = ct.id) where ct.id_main=%d order by mv.num asc";
    $params = array($id,);
    return $this->db->fetchData($sql, $params);
  }
public function delMovePointInfo($id)
  {
    return $this->db->deleteRow($this->table, "id", $id, '%d');
  }

}
?>