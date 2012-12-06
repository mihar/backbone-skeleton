# Sample master class called 'App' that holds everything together.
# You call this one in the init.js.coffee.

class BBNS.App
  # Debug levels.
  debug: 0

  # Use Backbone's events in your master class.
  events: _.extend(BBNS.Events, Backbone.Events)

  ##
  ## INIT
  init: ->
    BBNS.log 'App init'
    @events.t 'init:start'

    # DOM dependent init.
    @events.on 'dom:onload', @dom_onload, this

    # Setup unload handlers.
    # Use this to prevent users to lose work by hitting the back button by mistake.
    # Bind to events that signal that some data is to be missing, like recording the first chunk of a translation.
    #
    # It's safe to use multiple times, it will bind the handlers only once.
    #
    # @events.on 'recording:start', @setup_unload_handler, this
    # @events.on 'video:processed', @cancel_unload_handler, this

    # Initialize main views.
    BBNS.overlay = new BBNS.OverlayView
    
    @events.on 'init:dom:end', -> 
      @events.t 'init:end'
    , this

  dom_onload: ->
    BBNS.log 'DOM loaded, proceeding'
    BBNS.app.dom_exists = true

    @events.t 'init:dom:start'

    # Setup router.
    @router = new BBNS.Router

    # Setup DOM.
    $('body').append BBNS.overlay.el

    @events.t 'init:dom:end'

  setup_unload_handler: ->
    return if window.onbeforeunload
    BBNS.log 'Setting up unload handler to prevent work loss.'
    window.onbeforeunload = -> "If you leave this page, the translations you made will be lost."
    
  cancel_unload_handler: -> 
    BBNS.log 'Releasing unload handler.'
    window.onbeforeunload = null
