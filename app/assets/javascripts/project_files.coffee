# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '#new-folder-link', ->
  $('#modal-new-folder').modal('open')
  $("#new_folder_name").focus()

$(document).on 'click', '#new_folder_btn', ->
  $('#modal-new-folder').modal('close')
  $.post(
    '/crear-carpeta',
    { project_id: $(this).data('project-id'), new_folder: $('#new_folder_name').val(), user_id: $(this).data('user-id') },
    (xhr) ->
      res = $.parseJSON(xhr)
      Materialize.toast(res['flash'], 3000)
      url = $('#folders-area').data('project-url') + '/documentos/carpetas'
      $.get url, (data) ->
        $('#folders-area').html(data)
        $('.folder-row').removeClass('folder-selected')
        $('#folder-' + res['new_folder_id']).addClass('folder-selected')
        $('#folder-' + res['new_folder_id']).click()
  )
  .fail( (data) ->
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
