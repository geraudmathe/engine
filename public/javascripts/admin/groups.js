$(document).ready(function() {
	$usersGroup = $( "#trash" )
	function UpdateUsersList( item ,container) {
				item.fadeOut(function() {
						ItemID = item.attr("data-user-id")
						$(container).append("<li data-user-id='"+ItemID+"' class='item'>\n\
																	"+item.text()+"\n\
																	<img class='remove' data-user-id='"+ItemID+"' src='/images/admin/list/icons/trash.png'/>\n\
																</li>");
						$.ajax({
						  url: "/admin/addgroupuser/"+current_group,
							data: "user_id="+item.attr("data-user-id")
						});
				});
	}
	
	$('#users_in_group .remove').live('click', function(event) {
				if ( confirm(message_remove_from_group) )
						ItemID = $(this).attr("data-user-id")
						$.ajax({
						  url: "/admin/removegroupuser/"+current_group,
							data: "user_id="+ItemID,
						  success: function(html){
								$("#user_id_"+ItemID).fadeOut()
						  }
						});
	        return false;
	    });
	
	$('#users_in_group a.remove').live('click', function(event) {
				if ( confirm("Are you sure you want to delete this Post?") )

	        return false;
	    });
	
	$( "#users_list li" ).draggable({
		cancel: "a.ui-icon", // clicking an icon won't initiate dragging
		revert: "invalid", // when not dropped, the item will revert back to its initial position
		helper: "clone",
		handle: "em",
		cursorAt: { cursor: "move", top: 5, left: 5 } 
	});
	$( "#users_in_group ul" ).droppable({
		activeClass: "ui-state-default",
		hoverClass: "ui-state-hover",
		accept: ":not(.ui-sortable-helper)",
		drop: function( event, ui ) {
			UpdateUsersList(ui.draggable,this);
		}
	});
});
