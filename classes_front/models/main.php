<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Model_Main extends Model{
private $tables = array();
public function __construct($cachedb)
  {
  parent::__construct($cachedb);
    $this->tables['mi'] = $this->db->wpdb->prefix."sial_main_info";
    $this->tables['bg'] = $this->db->wpdb->prefix.'sial_bg_images';
    $this->tables['ct'] = $this->db->wpdb->prefix.'sial_containers';
    $this->tables['it'] = $this->db->wpdb->prefix.'sial_items';
    $this->tables['im'] = $this->db->wpdb->prefix.'sial_images';
    $this->tables['tx'] = $this->db->wpdb->prefix.'sial_texts';
    $this->tables['mv'] = $this->db->wpdb->prefix.'sial_moves';
    $this->tables['mp'] = $this->db->wpdb->prefix.'sial_move_points';
    $this->tables['gr'] = $this->db->wpdb->prefix.'sial_groups';
  }
public function main_query()
  {
    $sql1 = "select mi.*, mi.effect_direction as mieffectdir, mi.effect as mieffect, mi.width as miwidth, mi.height as miheight,".
    " mi.duration as midur, mi.effect as mieffect, mi.duration_effect as mide, '' as delim1, ctn.*, ctn.id as ctnid, ctn.duration".
    " as ctndur, ctn.effect_direction as ctneffectdir,".
    " ctn.effect as ctneffect, bgi.*, bgi.url as bgurl, bgi.image as bgimage, bgi.name as bgname, it.*, gr.*, '' as delim2, gr.id as grid,".
    " im.*, im.name as imname, im.width as imwidth, im.height as imheight, im.image as imimage, im.url as imurl, im.grouppos as imgrouppos,".
    " 'img' as imtype, im.offsetleft as imoffsetleft, im.offsettop as imoffsettop, im.classes_list as imclasses_list, '' as delim3,".
    " tx.*, tx.width as txwidth, tx.height as txheight, tx.text as txtext, tx.url as txurl, tx.grouppos as txgrouppos,".
    " 'txt' as txtype, tx.offsetleft as txoffsetleft, tx.offsettop as txoffsettop, tx.classes_list as txclasses_list,".
    " tx.size as txsize from ".
    $this->tables['mi']." as mi left join ".$this->tables['ct']." as ctn on (mi.id = ctn.id_main)".
    " left join ".$this->tables['bg']." as bgi on (ctn.id_bg_image = bgi.id)".
    " left join ".$this->tables['it']." as it on (it.id_container = ctn.id)".
    " left join ".$this->tables['gr']." as gr on (it.id_group = gr.id)".
    " left join ".$this->tables['im']." as im on (im.groupid = gr.id)".
    " left join ".$this->tables['tx']." as tx on (tx.groupid = gr.id)".
    " where mi.id=%d order by ctn.num";

    $sql2 = "select mi.id as miid, ctn.id as ctnid, mv.*, mv.num as mvnum, mv.width as mvwidth, mv.height as mvheight,".
    " mv.url as mvurl,  '' as delim1, ".
    " mp.*, mp.num as mpnum, mp.size as mpsize, '' as delim2, gr.id as grid,".
    " im.*, im.width as imwidth, im.height as imheight, im.image as imimage, im.url as imurl, im.grouppos as imgrouppos,".
    " 'img' as imtype, im.offsetleft as imoffsetleft, im.offsettop as imoffsettop, '' as delim3,".
    " tx.*, tx.width as txwidth, tx.height as txheight, tx.text as txtext, tx.url as txurl, tx.grouppos as txgrouppos,".
    " tx.offsetleft as txoffsetleft, tx.offsettop as txoffsettop, 'txt' as txtype, tx.offsetleft as txoffsetleft,".
    " tx.offsettop as txoffsettop, tx.classes_list as txclasses_list, tx.size as txsize ".
    " from ".$this->tables['mi'].
    " as mi left join ".$this->tables['ct']." as ctn on (mi.id = ctn.id_main)".    
    " left join ".$this->tables['mv']." as mv on (ctn.id = mv.id_container)".
    " left join ".$this->tables['mp']." as mp on (mv.id = mp.id_move)".
    " left join ".$this->tables['gr']." gr on (mv.source = gr.id)".
    " left join ".$this->tables['im']." as im on (im.groupid = gr.id)".
    " left join ".$this->tables['tx']." as tx on (tx.groupid = gr.id)".
    " where mi.id=%d order by ctn.num, mv.num, mp.num";
    
    return array($sql1, $sql2);
  }
public function get_main_results($id)
  {
  list($sql1, $sql2) = $this->main_query();

    $params = array($id,);
      $items = $this->db->fetchDataMain($sql1, $params, 'items');

    $params = array($id,);
      $moves = $this->db->fetchDataMain($sql2, $params, 'moves');
   return array($items, $moves);
  }
}
