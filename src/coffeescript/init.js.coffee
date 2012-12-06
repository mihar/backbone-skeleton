##
## INIT
BBNS.app = new BBNS.App
BBNS.app.events.on 'router:init:end', -> Backbone.history.start pushState: true
BBNS.app.init()

$ -> BBNS.app.events.t 'dom:onload'