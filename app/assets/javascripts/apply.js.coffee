class Application
  constructor: () ->
    @submit()

  getInfo: () ->
    @firstName = $("#firstName").val()
    @lastName = $("#lastName").val()
    @email = $("#email").val()
    @personalVideo = $('#personalintro').val()
    @linkedin = $("#linkedinprofile").val()
    @github = $("#githubprofile").val()

  submit: () ->
    $("#submitapplication").click (event) =>
      @getInfo()
      if @validatePresence() is true
        $.ajax
          type: "POST"
          url: "/apply.json"
          data: 
            first_name: @firstName
            last_name: @lastName
            email: @email
            intro_video: @personalVideo
            linkedin: @linkedin
            github: @github
          success: (response) =>
            if response.status is 200
              $('#appsuccess').foundation('reveal', 'open');
            if response.status is 400
              $('#apperror').foundation('reveal', 'open');

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
