# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#photo_file').attr('name','photo[file]')
  $('#new_photo').fileupload
    dataType: 'script'
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png|mov|mpeg|mpeg4|avi)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#new_photo').append(data.context)
        $('.actions input[type="submit"]').click (e) ->
          $('.actions input[type="submit"]').attr("disabled", true)
          data.submit()
          e.preventDefault()           
      else
        alert("#{file.name} is not a gif, jpg or png image file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    done: (e, data) ->
      $('.actions input[type="submit"]').off('click')
      $('.actions input[type="submit"]').attr("enabled", true)