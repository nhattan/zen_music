jQuery ->
  $('#fileupload').fileupload
    maxNumberOfFiles: 1
    dataType: 'script'
    add: (e, data) ->
      $("#save_audio").attr('disabled', 'disabled')
      types = /(\.|\/)(mp3|wav|m4a)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#fileupload').append(data.context)
        file_name = file.name.split('.')[0]
        $('#audio_name').val(file_name) unless $('#audio_name').val()
        data.submit()
      else
        alert("#{file.name} is not an valid file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.progress-bar').css('width', progress + '%')
        data.context.find('#js-completed').html(progress + "%")

  if gon.uploaded_file_url
    jwplayer('my-player').setup
      file: gon.uploaded_file_url
      height: 150
