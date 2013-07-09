FishLang.SentenceController = Ember.ObjectController.extend(
  
  check: ->
    data = {subject: $('#subject').val()}
    check_url = '/sentences/' + @get('id') + '/check'
    success_url = '/practices/' + @get('practice.id') + '/done'

    Ember.$.post(check_url, data).then (response) ->
    
      if response.next_id == null
        $("#check_btn").attr('disabled', 'disabled')
        $("#continue_btn").attr('disabled', 'disabled')
        window.location.href = success_url 

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

  report: ->
    return $('.dropdown-menu').hide() if $('.dropdown-menu').is(":visible")
    $('.dropdown-menu').show()

  cancel_report: ->
    $('.dropdown-menu').hide()

  submit_report: ->
    report_url = '/sentences/' + @get('id') + '/report'
    content = ''
    user_answer = $('#subject').val()
    others_content = $('#others_content').val()
    $("input[name='contents']:checked").each ->
      content = content + @value + ' '

    content = content + others_content

    data = {user_answer: user_answer, content: content}

    Ember.$.post(report_url, data).then (response) ->
      $('.dropdown-menu').hide()
      $('#notice').attr('display', 'block')
      $("#notice").show();
      $("#notice").hide(5000);
    
)


