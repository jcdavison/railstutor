$('a[href^="#"]').click (e) ->
  e.preventDefault()
  target = @hash
  $target = $(target)

  $('html, body').stop().animate(
    {'scrollTop': $target.offset().top},
    600, 'swing', () ->
      window.location.hash = target
  )
