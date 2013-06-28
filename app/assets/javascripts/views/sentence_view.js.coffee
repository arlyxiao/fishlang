FishLang.SentenceView = Ember.View.extend(
  didInsertElement: ->
    $('#subject').focus()

  keyPress: (event) ->
    if $.trim($('#subject').val()) == ''
      $("#check_btn").attr('disabled', 'disabled')
      $("#continue_btn").attr('disabled', 'disabled')
      return

    $("#check_btn").removeAttr('disabled')
    if event.keyCode == 13
      if $("#check_btn").is(":disabled") && !$("#continue_btn").is(":disabled")
        $('#continue_btn').trigger('click')
        $('#check_btn').focus()

      if !$("#check_btn").is(":disabled") && $("#continue_btn").is(":disabled")
        $('#check_btn').trigger('click')
        $('#continue_btn').focus()
)
