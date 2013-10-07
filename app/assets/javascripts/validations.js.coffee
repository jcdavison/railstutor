class Payment
  constructor: () ->
    @pay()

  newPmt: () ->
    @firstName = $("#firstName").val()
    @lastName = $("#lastName").val()
    @email = $("#email").val()
    @cardNumber = $('#cardNumber').val()
    @expMonth = $('#expMonth').val()
    @expYear = "20#{$('#expYear').val()}"
    @cvc = $('#cardCvv').val()
    @pmtToken = null
    @last4 = null

  confirmPmt: () ->
    $("#last4").text @last4
    $("#confirmFirstName").text @firstName
    $("#confirmLastName").text @lastName
    $("#confirmEmail").text @email
    $('#confirmPmt').foundation('reveal', 'open');
    @submitPmt()

  submitPmt: () ->
    $("#submitPmt").click =>
      $.ajax
        type: "POST"
        url: "/main.json"
        data: 
          first_name: @firstName
          last_name: @lastName
          email: @email
          pmt_token: @pmtToken
        success: (response) =>
          if response.message
            $('#welcome').text "Welcome #{@firstName} !"
            $('#confirmPmt').foundation('reveal', 'close');
            $("#thankYou").foundation('reveal', 'open')
            @resetPage()
          if response.error
            $('#confirmPmt').foundation('reveal', 'close');
            @cardError(response.error)

  resetPage: () ->
    $('#closeThankYou').click ->
      window.location = "https://www.rubyonrailstutor.com"
    
  cardError: (errors = null) ->
    if errors
      $("#errors").text errors
    $('#cardError').foundation('reveal', 'open');


  pay: () ->
    $("#pay").click =>
      @newPmt()
      if @validatePresence() is true
      else
        return false
      if @validateCard() is true 
        @getPmtToken()
      else
        @cardError()
        return false

  getPmtToken: () ->
    Stripe.card.createToken(
      number: @cardNumber 
      cvc: @cvc 
      exp_month: @expMonth 
      exp_year: @expYear 
    , 
    (status, response) => 
      if response.errors
        @cardError(response.errors)
        return false
      unless response.errors
        @pmtToken = response.id
        @last4 = "'#{response.card.last4}'"
        @confirmPmt()
    )

  validateCard: () ->
    if Stripe.card.validateCardNumber(@cardNumber) &&
      Stripe.card.validateCVC(@cvc) &&
      Stripe.card.validateExpiry(@expMonth, @expYear)
        return true
    else
      false

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
payment = new Payment
