FishLang.SentenceController = Ember.ObjectController.extend(
  
  check: ->
    data = {subject: $('#subject').val()}
    url = '/sentences/' + @get('id') + '/check'
    Ember.$.post(url, data).then (response) ->
      if response > 0
        $('#continue_btn').val(response)
        $("#check_btn").attr('disabled', 'disabled')
        $("#continue_btn").removeAttr('disabled')
        $('#continue_btn').focus()
      else
        alert(response)
      

  continue: ->
    @transitionToRoute 'sentence', FishLang.Sentence.find($('#continue_btn').val())
    $("#continue_btn").attr('disabled', 'disabled')
    $("#check_btn").removeAttr('disabled')
    $('#check_btn').focus()
    $('.translation_box').val('')
)

