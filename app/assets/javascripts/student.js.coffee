class Student extends Validation
  constructor: () ->
    @firstName = null
    @lastName = null
    @email = null
    @linkedin = null
    @github = null
    @video = null
    @phone = null
    @applied = false
    @join()
    @learnMore()
    @apply()
    

  learnMore: () ->
    $(".learnmore").click ->
      $("#join").foundation("reveal", "open")

  getFullInfo: () ->
    @getInfo()
    @linkedin = $("#linkedin").val()
    @github = $("#github").val()
    @video = $("#video").val()
    @phone = $("#phone").val()

  getInfo: () ->
    @firstName = $("#firstName").val()
    @lastName = $("#lastName").val()
    @email = $("#email").val()


  join: () ->
    $("#submit").click (event) =>
      if @validatePresence() is true
        @getInfo()
        $("#submit, #submitspinner").toggle "invisible"
        $.ajax
          type: "POST"
          url: "/join.json"
          data: 
            first_name: @firstName
            last_name: @lastName
            email: @email
            applied: false
          success: (response) =>
            console.log response
            if response.status is 200
              @confirm(response, "submit")
            if response.status is 400
              $('#emailerror').foundation('reveal', 'open');

  confirm: (response, submit_context) ->
    $("#confirmationEmail").text response.email
    $("#confirmationMessage").text response.message
    $("##{submit_context}").toggle "invisible"
    $("#submitspinner").toggle "invisible"
    $('#jointoday').foundation('reveal', 'close');
    $('#welcome').foundation('reveal', 'open');


  apply: () ->
    $("#apply").click (event) =>
      if @validatePresence() is true
        @getFullInfo()
        $("#apply").toggle "invisible"
        $.ajax
          type: "POST"
          url: "/join.json"
          data: 
            something: "else"
            first_name: @firstName
            last_name: @lastName
            email: @email
            linkedin: @linkedin
            github: @github
            video: @video
            phone: @phone
            applied: true
          success: (response) =>
            @confirm(response, "apply")


application = new Student
