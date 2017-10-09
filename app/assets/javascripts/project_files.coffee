# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '#new-folder-link', ->
  $('#modal-new-folder').modal('open')
  $("#new_folder_name").focus()

$(document).on 'click', '#new_folder_btn', ->
  $('#modal-new-folder').modal('close')
  folder_name = $('#new_folder_name').val()
  url = $(this).data('url')
  $.post(
    url,
    { "project_folder[name]": $('#new_folder_name').val() },
    (xhr) ->
      res = $.parseJSON(xhr)
      Materialize.toast(res['flash'], 3000)
  )

$(document).on 'click', '.file-delete', ->
  if confirm '¿Eliminar archivo?' 
    $.ajax '/archivos/' + $(this).data('project-folder-file-id'),
           type: 'DELETE'

@reloadFilesArea = reloadFilesArea = () ->
  url = $('#files-area').data('list-url')
  $.get url, (data) ->
    $('#files-area').html(data)

$(document).on "ready turbolinks:load", ->
  project_files_init()

project_files_init = () ->
  $('#modal-new-folder').modal()
  $('#files-dropzone').dropzone
    paramName: 'project_file[file]'
    dictDefaultMessage: 'Para subir archivos, da click o arrastralos aquí.'
    complete: (file) ->
      @removeFile file
      reloadFilesArea()
      return
