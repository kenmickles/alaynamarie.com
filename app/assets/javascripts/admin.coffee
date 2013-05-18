#= require jquery
#= require jquery_ujs
#= require jquery-ui

$ ->
  return unless $('body').is('.admin')

  # close flash notices then the "x" is clicked
  $('.alert a.close').click (e) ->
    e.preventDefault()
    $(@).closest('.alert').slideUp()

  # make photos sortable
  $('body.books.edit ul.thumbnails').sortable().disableSelection()

  # add photo_ids param before submitting the book form
  $('body.books.edit form.book').submit (e) ->
    photo_ids = []

    $('.thumbnail').each ->
      photo_ids.push $(@).data('id')

    $(@).append('<input type="hidden" name="photo_ids" value="' + photo_ids.join(',') + '">')
