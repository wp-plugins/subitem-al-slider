<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Sial_CacheDb extends Sial_Db{
public function __construct()
  {
  if (method_exists(get_parent_class(), '__construct'))
      parent::__construct();
  }
public function fetchDataMain($sql, $params, $type)
  {
  global $subitemal_cache_db;
  global $subitemal_cache_sql_expiration;
  $fullSql = $this->wpdb->prepare($sql, $params);
    if (!($subitemal_cache_db)||(($cache = wp_cache_get( $fullSql, 'main_front' )) === false))
      {
        $data = $this->filterMainData($this->fetchDatafullQuery($fullSql), $type);
          wp_cache_add( $fullSql, $data, 'main_front', $subitemal_cache_sql_expiration );
          return $data;
      }
      else
      {
        return $cache;
      }
  }
public function filterMainData($data, $type)
  {
    switch ($type)
      {
      case 'items' : $result = $this->prepear_items($data);
        break;
      case 'moves' : $result = $this->prepear_moves($data);
        break;
      }

    return $result;
  }
public function prepear_items($data)
  {
  $main = array();

    foreach ($data as $dt)
      {
      $fl = false;
      $fl2 = false;
      $fl3 = false;
          foreach ($dt as $key=>$val)
            {
              if ($key == 'delim1')$fl = true;
              if ($key == 'delim2'){$fl2 = true; $fl=false;}
              if ($key == 'delim3'){$fl3 = true;$fl2 = false; $fl=false;}

              if (isset($val))
              if ($fl)
                {
                  $main['containers'][$dt->ctnid][$key] = $val;
                }
                elseif (($fl2)&&(isset($dt->imimage)))
                {
                  $main['containers'][$dt->ctnid]['groups'][$dt->grid][(int)$dt->imgrouppos][$key] = $val;
                }
                elseif (($fl3)&&(isset($dt->txtext)))
                {
                  $main['containers'][$dt->ctnid]['groups'][$dt->grid][(int)$dt->txgrouppos][$key] = $val;
                }
                else
                {
                  $main['main'][$key] = $val;
                }
            }
      }
            $main = $this->sort_groups($main);

    return $main;
  }
public function prepear_moves($data)
  {
  $moves = array();
    foreach ($data as $dt)
      {
      $fl = false;
      $fl2 = false;
      $fl3 = false;
          foreach ($dt as $key=>$val)
            {
              if ($key == 'delim1')$fl = true;
              if ($key == 'delim2'){$fl2 = true; $fl=false;}
              if ($key == 'delim3'){$fl3 = true;$fl2 = false; $fl=false;}

              if (isset($val))
              if ($fl)
                {
                  $moves[$dt->ctnid]['moves'][$dt->mvnum]['move_points'][$dt->mpnum][$key] = $val;
                }
                elseif (($fl2)&&(isset($dt->imimage)))
                {
                  $moves[$dt->ctnid]['moves'][$dt->mvnum]['groups'][$dt->grid][(int)$dt->imgrouppos][$key] = $val;
                }
                elseif (($fl3)&&(isset($dt->txtext)))
                {
                  $moves[$dt->ctnid]['moves'][$dt->mvnum]['groups'][$dt->grid][(int)$dt->txgrouppos][$key] = $val;
                }
                else
                {
                  $moves[$dt->ctnid]['moves'][$dt->mvnum][$key] = $val;
                }
            }
      }
            $moves = $this->sort_move_groups($moves);
    return $moves;
  }
public function sort_groups($data)
  {
 if ((isset($data['containers']))&&(is_array($data['containers'])&&(!empty($data['containers']))))
    foreach ($data['containers'] as &$dt)
      {
    if ((isset($dt['groups']))&&(is_array($dt['groups']))&&(!empty($dt['groups'])))
        foreach ($dt['groups'] as &$dtgr)
          {
          foreach ($dtgr as &$dtgrinside)
            {
            ksort($dtgrinside, SORT_NUMERIC);
            }
          }
      }
    return $data;
  }
public function sort_move_groups($data)
  {
    foreach ($data as &$dt)
      {
        foreach ($dt['moves'] as &$dtgr)
          {
          if (isset($dtgr['groups'])&&(!empty($dtgr['groups']))&&(is_array($dtgr['groups'])))
           {
          foreach ($dtgr['groups'] as &$din)
            {
              ksort($din, SORT_NUMERIC);
            }
           }
          }
      }
    return $data;
  }

}
?>