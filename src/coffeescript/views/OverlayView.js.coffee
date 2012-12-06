# Sample Backbone view 'OverlayView'.
#
# Instantiate an instance of it using:
#   overlay_view = new BBNS.OverlayView
#
# The template for this view is in src/templates/overlay.js.hamlc
#
# Then render it and append it to the DOM:
#   $('body').append overlay_view.render().el

class BBNS.OverlayView extends Backbone.View
  id: 'overlay'
  template: HAML['overlay']


  initialize: ->
    BBNS.info 'OverlayView initializing'

  render: ->
    $@el.html @template()
    this