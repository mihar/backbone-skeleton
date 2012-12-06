# Sample Backbone view 'RootView'.
#
# Instantiate an instance of it using:
#   overlay_view = new BBNS.RootView
#
# The template for this view is in src/templates/overlay.js.hamlc
#
# Then render it and append it to the DOM:
#   $('body').append overlay_view.render().el

class BBNS.RootView extends Backbone.View
  id: 'root'
  template: HAML['root']

  initialize: ->
    BBNS.info 'RootView initializing'

  show: (message) -> @$('h1').text message

  render: ->
    BBNS.info 'RootView rendering'
    @$el.html @template()
    this