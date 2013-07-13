FishLang.SentenceController = Ember.ObjectController.extend(
  
  check: ->
    data = {subject: $('#subject').val()}
    check_url = '/sentences/' + @get('id') + '/check'
    success_url = '/practices/done'

    Ember.$.post(check_url, data).then (response) ->
      window.location.href = success_url if response == null

      $('#practice_error_count').html(response.error_count)
      $('#practice_done_count').html(response.done_count)

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
    id = $('#continue_btn').val()
    window.location.href = "/lessons" if id == null

    @transitionToRoute 'sentence', FishLang.Sentence.find(id)
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
    others_content1 = $('#wrong_box .others_content').val()
    others_content2 = $('#correct_box .others_content').val()
    others_content = others_content1 + others_content2

    $("input[name='contents']:checked").each ->
      content = content + @value + ' '

    content = content + others_content

    data = {user_answer: user_answer, content: content}

    Ember.$.post(report_url, data).then (response) ->
      $('.dropdown-menu').hide()
      $('.notice_report').attr('display', 'block')
      $(".notice_report").show();
      $('#continue_btn').focus()
      $(".notice_report").hide(5000);
    
)


