# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '#add-new-status', () ->
  url = $(this).data('url')
  $.post(
    url + '/add-status',
    { new_status: $('#new_status').val() },
    (xhr) ->
      res = $.parseJSON(xhr)
      Materialize.toast(res['flash'], 3000)
      $.get(url + '/statuses', {}, (html) ->
        $('#estados').empty().html(html)
      )
  )
  .fail( (data) ->
    Materialize.toast(res['flash'], 3000)
  )


$(document).on 'change', '.project-status-item', () ->
  url = $('#sortable-statuses').data('url') + '/update-status/'
  $.post(
    url,
    { psid: $(this).data('id'), value: $(this).val() },
    (xhr) ->
      res = $.parseJSON(xhr)
      Materialize.toast(res['flash'], 3000)
      Waves.ripple('#ps-' + res['psid'])
  )
