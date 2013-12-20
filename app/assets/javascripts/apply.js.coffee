class Application
  constructor: () ->
    @submit()
    @learnMore()

  learnMore: () ->
    $(".learnmore").click ->
      $("#join").foundation("reveal", "open")

  getInfo: () ->
    @firstName = $("#firstName").val()
    @lastName = $("#lastName").val()
    @email = $("#email").val()

  submit: () ->
    $("#submit").click (event) =>
      console.log "hey"
      @getInfo()
      if @validatePresence() is true
        $.ajax
          type: "POST"
          url: "/apply.json"
          data: 
            first_name: @firstName
            last_name: @lastName
            email: @email
          success: (response) =>
            if response.status is 200
              $("#confirmationEmail").text response.email
              $("#confirmationMessage").text response.message
              $('#jointoday').foundation('reveal', 'close');
              $('#welcome').foundation('reveal', 'open');
            if response.status is 400
              $('#emailerror').foundation('reveal', 'open');

  validatePresence: () ->
    select = $(".validates-presence")
    if select.length is 0
      return true
    if select.length > 0
      errors = 0
      $("input.validates-presence").each ( index, element ) =>
        if $(element).val().length isnt 0 && $(element).hasClass("error")
          $(element).removeClass("error")
        if $(element).val().length is 0
          $(element).addClass("error")
          mixpanel.track "emptyInput", emptyId: element.id
          @presenceErrorRelease(element)
          errors += 1
    if errors is 0
      return true
    else
      return false

  presenceErrorRelease: (element) ->
    $(element).focus =>
      $(element).blur ->
        if $(element).val().length isnt 0 && $(element).hasClass("error")
          $(@).removeClass("error")

application = new Application
