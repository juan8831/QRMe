vex.closeAll()
toastr.success("The selected event was successfully updated", "Event updated")
$(".main-table-container")
  .before("<%= j render 'events_list', event_instances: @event_instances %>")
  .remove()
