window.Tracker = class Tracker
  constructor: (@mixpanel) ->
    @trackPageLoad()
    @trackClick()

  showModal: () ->
    $(document).ready () ->
      $("#join").foundation("reveal", "open")

  trackPageLoad: () ->
    mixpanel = @mixpanel
    $(document).ready () ->
      mixpanel.track("pageload", {"location": window.location.pathname})

  trackClick: () ->
    mixpanel = @mixpanel
    $("button, input, .learnmore").click (event) ->
      mixpanel.track("click", {targetId: event.target.id})
