# Sample Backbone model 'Fragment'.
#
# Instantiate instances of it using:
#   fragment_1 = new BBNS.Fragment
#   fragment_2 = new BBNS.Fragment
#   fragment_3 = new BBNS.Fragment

class BBNS.Fragment extends Backbone.Model
  initialize: ->
    BBNS.info 'Fragment initialized'