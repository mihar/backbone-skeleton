# Protection against exceptions when window.console is not defined.
window.console = {} if not window.console
unless console.log
  console.log = ->
unless console.warn
  console.warn = ->
unless console.error
  console.error = ->
unless console.info
  console.info = ->

# Main log output function.
BBNS.console_output = ->
  args = Array.prototype.slice.call(arguments)

  # Filter out output function.
  output_routine = args[0]
  args.shift()
  return unless output_routine

  if args.length > 1
    level = parseInt args[0]
    if [0, 1, 2, 3, 4, 5, 6].indexOf(level) > -1
      args.shift()
      return false if BBNS.app.debug < level

  level = 0 if isNaN level
  level = 0 unless level?

  # Timestamp.
  date = new Date
  timestamp = "#{date.getUTCFullYear()}-#{date.getUTCMonth()+1}-#{date.getUTCDate()}@#{date.getUTCHours()}:#{date.getUTCMinutes()}:#{date.getUTCSeconds()}.#{date.getUTCMilliseconds()}"

  # Message is separate.
  msg = args[0]
  if args.length > 1
    args.shift()
  else
    args = []

  console[output_routine] "[#{level}:#{timestamp}] #{msg}", args...
  true


# Actual log functions you use in your app.
#
# The usual is to use them like this:
# BBNS.log <Some message string here>, [<obj1>, <obj2>, <obj3>]
# Example:
#   BBNS.log 'This is the current browser window object', window
#   BBNS.error 'Whoops, we are out of stock on Simon Talek', window.location
#
# It basically works like console.log, just that the first argument should 
# always be some kind of a message, what's happening, followed by an arbitrary
# number of objects, that will be output verbatim.
#
BBNS.log = -> BBNS.console_output 'log', arguments...
BBNS.info = -> BBNS.console_output 'info', arguments...
BBNS.warn = -> BBNS.console_output 'warn', arguments...
BBNS.error = -> BBNS.console_output 'error', arguments...