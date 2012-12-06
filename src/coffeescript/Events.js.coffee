# A class which we'll extend with the Backbone's events and then use as our app-wide dispatcher.
# See App.js.coffee where we use _.clone for this.
#
BBNS.Events =
  # The t method is a shorthand for the usual Backbone.Events trigger method, 
  # but this one logs triggered events.
  t: (event_name, options = {}) ->
    BBNS.log 6, "EVENT Triggered '#{event_name}'", options
    @trigger event_name, options