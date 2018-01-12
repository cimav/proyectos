# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '#update-status-link', ->
  $('#modal-status').modal('open')

$(document).on "ready turbolinks:load", ->
  project_init()

project_init = () ->
  $('#modal-status').modal()
  $('.datepicker').pickadate({
      format: 'yyyy-mm-dd',
      selectMonths: true,
      selectYears: 15, 
      today: 'Hoy',
      clear: 'Limpiar',
      close: 'Ok',
      closeOnSelect: false 
    });