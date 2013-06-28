FishLang.SentenceController = Ember.ObjectController.extend(
  
  check: ->
    data = {subject: $('#subject').val()}
    url = '/sentences/' + @get('id') + '/check'
    Ember.$.post(url, data).then (response) ->
      if response.result == true
        $('#continue_btn').val(response.next_id)
        $("#check_btn").attr('disabled', 'disabled')
        $(".translation_box").attr('disabled', 'disabled')
        $("#correct_box").show();
        $("#continue_btn").removeAttr('disabled')
        $('#continue_btn').focus()
      else
        $('#continue_btn').val(response.next_id)
        $("#wrong_box").show();
        $(".translation_box").attr('disabled', 'disabled')
        $("#check_btn").attr('disabled', 'disabled')
        $("#continue_btn").removeAttr('disabled')
        $('#continue_btn').focus()
      

  continue: ->
    @transitionToRoute 'sentence', FishLang.Sentence.find($('#continue_btn').val())
    $("#continue_btn").attr('disabled', 'disabled')
    $("#check_btn").removeAttr('disabled')
    $('#translation_box').focus()
    $('.translation_box').val('')
    $("#wrong_box").hide();
    $("#correct_box").hide();
    $(".translation_box").removeAttr('disabled')
)

