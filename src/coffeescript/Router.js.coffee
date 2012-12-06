# Let's create a Backbone router here, for mapping URLs to states in the app.
#
class BBNS.Router extends Backbone.Router
  routes:
    '': 'root'
    '/hello': 'hello'
    '/world': 'world'

  initialize: ->
    BBNS.log 'Router init'
    BBNS.app.events.t 'router:init:end'

  # Root is the route that is initiated when we hit the root of our app.
  root: -> BBNS.app.root()

  # Define other custom routes ...
  hello: -> BBNS.warn 'Hello route here'
  world: -> BBNS.warn 'World route here'