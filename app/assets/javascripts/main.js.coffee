window.Tracker = class Tracker
  constructor: (@mixpanel) ->
    @trackPageLoad()
    @trackClick()

  trackPageLoad: () ->
    mixpanel = @mixpanel
    $(document).ready () ->
      mixpanel.track("pageload", {"location": window.location.pathname})

  trackClick: () ->
    mixpanel = @mixpanel
    $(document.body, "#pay").click (event) ->
      console.log event.target.id
      mixpanel.track("click", {targetId: event.target.id})
