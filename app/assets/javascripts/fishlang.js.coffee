#= require ./store
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates
#= require_tree ./routes
#= require ./router
#= require_self


FishLang.Store = DS.Store.extend(
  revision: 12
  adapter: "DS.RESTAdapter"
)

FishLang.Sentence = DS.Model.extend(
  subject: DS.attr("string")
)


FishLang.SentenceView = Ember.View.extend(
  didInsertElement: ->
    $('#subject').focus()

  keyPress: (event) ->
    $("#check_btn").removeAttr('disabled')
    if event.keyCode == 13
      if $("#check_btn").is(":disabled") && !$("#continue_btn").is(":disabled")
        $('#continue_btn').trigger('click')
        $('#check_btn').focus()

      if !$("#check_btn").is(":disabled") && $("#continue_btn").is(":disabled")
        $('#check_btn').trigger('click')
        $('#continue_btn').focus()
)


FishLang.LessonController = Ember.ObjectController.extend(
  
  start: ->
    @transitionToRoute 'sentence', FishLang.Sentence.find($('#start_btn').val())
      
)



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


FishLang.Router.map ->
  @resource "lessons", ->
    @resource "lesson",
      path: ":lesson_id", ->

  @resource "sentences", ->
    @resource "sentence",
      path: ":sentence_id", ->
