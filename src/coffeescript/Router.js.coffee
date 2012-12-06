# We make a Backbone router here, for mapping URLs to states in the app.
#
class BBNS.Router extends Backbone.Router
  routes:
    '': 'root'
    '/hello': 'hello'
    '/world': 'world'

  initialize: ->
    BBNS.log 'Router init'
    BBNS.app.events.t 'router:init:end'

  root: -> 
    BBNS.app.fatal_error 'Error wrong parameters' unless BBNS.app.debug_mode
    BBNS.overlay.video_url()

  translate_video: (video_url, tag, auth_key, callback_url, kombajn_url) ->
    kombajn_url = decodeURIComponent decodeURIComponent kombajn_url if kombajn_url

    if kombajn_url? and kombajn_url is 'none'
      BBNS.app.fatal_error 'No kombajn available at this time. Try again later.'
      return

    BBNS.app.kombajn_url = kombajn_url
    BBNS.app.kombajn_job_id = BBNS.app.kombajn_url.split('/')[3] if kombajn_url

    # Tag
    if tag
      BBNS.app.tag = decodeURIComponent tag 
      tag = BBNS.app.tag.split('-')
      BBNS.app.video_id = tag[0]
      BBNS.app.language_code = tag[1]
    
    # Callback
    BBNS.app.callback_url = decodeURIComponent decodeURIComponent callback_url if callback_url != 'none'

    # Load the video
    if video_url and video_url = decodeURIComponent decodeURIComponent(video_url)
      if video_url is 'none'
        BBNS.app.fatal_error 'ERROR! No video URL received.'
      else
        video_url = decodeURIComponent(video_url) if video_url.match(/%/)
        BBNS.app.load_video video_url

    BBNS.log 6, 'Route "translate_video"', video_url, tag, auth_key, callback_url, kombajn_url