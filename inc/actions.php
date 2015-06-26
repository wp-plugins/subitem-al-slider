<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

//Ajax actions
 $db = new Sial_Db();
 
    $bgImagesController = new Controller_BgImages(new Model_BgImages($db));
      add_action("wp_ajax_sial_saveBgData_ajax", array($bgImagesController, "saveBgData_ajax"));
      
    $itemImagesController = new Controller_ItemImages(new Model_ItemImages($db));
      add_action("wp_ajax_sial_saveImageData_ajax", array($itemImagesController, "saveImageData_ajax"));

    $itemTextsController = new Controller_ItemTexts(new Model_ItemTexts($db));
      add_action("wp_ajax_sial_saveTextData_ajax", array($itemTextsController, "saveTextData_ajax"));

    $containerController = new Controller_Containers(new Model_Containers($db));
      add_action("wp_ajax_sial_saveContainerData_ajax", array($containerController, "saveContainerData_ajax"));
      add_action("wp_ajax_sial_saveContainersPositions_ajax", array($containerController, "saveContainersPositions_ajax"));

    $itemController = new Controller_Items(new Model_Items($db));
      add_action("wp_ajax_sial_saveItemData_ajax", array($itemController, "saveItemData_ajax"));
      add_action("wp_ajax_sial_delItemData_ajax", array($itemController, "delItemData_ajax"));

    $moveController = new Controller_Moves(new Model_Moves($db));
      add_action("wp_ajax_sial_saveMoveData_ajax", array($moveController, "saveMoveData_ajax"));
      add_action("wp_ajax_sial_delMoveRow_ajax", array($moveController, "delMoveRow_ajax"));
      
    $movepointController = new Controller_MovePoints(new Model_MovePoints($db));
      add_action("wp_ajax_sial_saveMovePointData_ajax", array($movepointController, "saveMovePointData_ajax"));
      add_action("wp_ajax_sial_delMovePointData_ajax", array($movepointController, "delMovePointData_ajax"));


?>