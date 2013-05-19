#= require jquery
#= require jquery_ujs
#= require modernizr
#= require swipe
#= require jquery.lazyload

log = (message) -> console?.log(message)

$ ->
  # set up slider nav
  swipe = new Swipe document.getElementById('slider'),
    # update active thumbnail + location hash on photo change
    callback: (index, el) ->
      $('.thumbnails a').removeClass('active')
      $(".thumbnails a[data-index=#{index}]").addClass('active')
      location.hash = "#photo#{index}"
      true

  $('.next').click (e) ->
    e.preventDefault()
    swipe.next()

  $('.prev').click (e) ->
    e.preventDefault()
    swipe.prev()

  $('.thumbnails a').click (e) ->
    e.preventDefault()
    swipe.slide $(@).data('index'), 300

  # add keyboard controls
  $(document).keyup (e) ->
    # left arrow or up arrow goes back
    if e.keyCode == 37 || e.keyCode == 38
      $('a.prev').click()
    # right arrow, down arrow, or space goes to the next photo
    else if e.keyCode == 39 || e.keyCode == 40 || e.keyCode == 32
      $('a.next').click()

  # if a photo is specified in the hash, scroll to it automatically
  if location.hash.match(/^#photo[0-9]/)
    index = location.hash.replace(/^#photo/, '')
    swipe.slide index, 300

  # update photo heights to fit window
  resize_photos = ->
    h = $('#slider').width() * 575/830
    $('#slider img.photo').height(h)

  $(window).resize(resize_photos)
  resize_photos()

  # lazyload images with a specific trigger, so it works on touch devices
  $('img.lazy').lazyload(event: 'lazyload').trigger('lazyload')