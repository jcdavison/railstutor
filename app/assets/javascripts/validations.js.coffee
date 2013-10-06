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
    @amount = 75000

  pay: () ->
    $("#pay").click =>
      @newPmt()
      if @validatePresence() is true
        console.log "valid form"
      else
        console.log "missing info"
        return false
      if @validateCard() is true
        console.log "valid card"
      else
        return false

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

      #   Stripe.card.createToken(
      #     number: number 
      #     cvc: cvc 
      #     exp_month: exp_month 
      #     exp_year: exp_year 
      #   , 
      #     (status, response) -> 
      #       unless response.error
      #         $.ajax
      #           type: "POST"
      #           url: "/main.json"
      #           data: 
      #             email: email
      #             name: name
      #             stripe: response
      #             amount: amount
      #           success: (json_data) ->
      #             if json_data.response isnt null
      #               message = "Welcome " + json_data.response
      #               console.log message
      #             $("#ResponseEmail").text(message)
      #             $("#thankyou").foundation('reveal', 'open')
