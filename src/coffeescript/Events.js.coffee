# A class which we'll extend with the Backbone's events and then use as our app-wide dispatcher.
# See App.js.coffee where we use _.clone for this.
#
BBNS.Events =
  t: (event_name, options = {}) ->
    V.log 6, "EVENT Triggered '#{event_name}'", options
    @trigger event_name, options