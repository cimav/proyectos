# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '#add-participant-link', ->
  $('#modal-new-participant').modal('open')

$(document).on 'click', '.participant-delete', ->
  if confirm '¿Eliminar participante?' 
    $.ajax '/participantes/' + $(this).data('project-participant-id'),
           type: 'DELETE'

@reloadParticipantsArea = reloadParticipantsArea = () ->
  url = $('#participants-area').data('list-url')
  $.get url, (data) ->
    $('#participants-area').html(data)

$(document).on "ready turbolinks:load", ->
  project_participants_init()

project_participants_init = () ->
  $('#modal-new-participant').modal()
