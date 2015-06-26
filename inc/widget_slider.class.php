<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

/**
 * Adds Slider_Widget widget.
 */
class Slider_Widget extends \WP_Widget {

  /**
  * Register widget with WordPress.
  */
  function __construct() {
    parent::__construct(
      'subitem_al_slider_widget', // Base ID
      __( 'Subitem AL Slider', 'text_domain' ), // Name
      array( 'description' => __( 'Adding of Subitem AL Slider', 'text_domain' ), ) // Args
    );
  }

  /**
  * Front-end display of widget.
  *
  * @see WP_Widget::widget()
  *
  * @param array $args     Widget arguments.
  * @param array $instance Saved values from database.
  */
  public function widget( $args, $instance ) {

    echo $args['before_widget'];
    if ( ! empty( $instance['title'] ) ) {
      echo $args['before_title'] . apply_filters( 'widget_title', $instance['title'] ). $args['after_title'];
    }
    echo do_shortcode("[subitem_al_slider id=".$instance['slider_id']."]");
    echo $args['after_widget'];
  }

  /**
  * Back-end widget form.
  *
  * @see WP_Widget::form()
  *
  * @param array $instance Previously saved values from database.
  */
  public function form( $instance ) {
     	        $title = ! empty( $instance['title'] ) ? $instance['title'] : __( '', 'text_domain' );
    ?>
    <p>
    <label for="<?php echo $this->get_field_id( 'title' ); ?>"><?php _e( 'Title:' ); ?></label> 
    <input class="widefat" id="<?php echo $this->get_field_id( 'title' ); ?>" name="<?php echo $this->get_field_name( 'title' ); ?>" type="text" value="<?php echo esc_attr( $title ); ?>">
    </p>

    <?php
    $slider = new Controller_MainInfo(new Model_MainInfo(new Sial_Db()));
    list($a, $all_projects, $c) = $slider->execute(1001);
    $output = "<select class='widefat'  id='".$this->get_field_id( 'slider_id' )."' name='".$this->get_field_name( 'slider_id' )."'>";

      foreach ($all_projects as $cur_prj)
      {
      if ($instance['slider_id'] == $cur_prj->id)
        $output .= "<option value='".$cur_prj->id."' selected='selected'>".$cur_prj->name."</option>";
        else
        $output .= "<option value='".$cur_prj->id."'>".$cur_prj->name."</option>";
      }
    $output .= "</select>";  
    echo $output;
    ?>
    <?php 
  }

	/**
	 * Sanitize widget form values as they are saved.
	 *
	 * @see WP_Widget::update()
	 *
	 * @param array $new_instance Values just sent to be saved.
	 * @param array $old_instance Previously saved values from database.
	 *
	 * @return array Updated safe values to be saved.
	 */
	public function update( $new_instance, $old_instance ) {
		$instance = array();
		$instance['title'] = ( ! empty( $new_instance['title'] ) ) ? strip_tags( $new_instance['title'] ) : '';
		$instance['slider_id'] = ( ! empty( $new_instance['slider_id'] ) ) ? (int)( $new_instance['slider_id'] ) : 1;

		return $instance;
	}

} // class Slider_Widget
?>