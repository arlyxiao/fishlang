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



FishLang.SentencesController = Ember.ArrayController.extend(
  sortProperties: [ "id" ]
  sortAscending: true
  filteredContent: (->
    @get("arrangedContent")
  ).property("arrangedContent.@each")
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
      else
        alert(response)
      

  continue: ->
    @transitionToRoute 'sentence', FishLang.Sentence.find($('#continue_btn').val())
    $("#continue_btn").attr('disabled', 'disabled')
    $("#check_btn").removeAttr('disabled')
    $('.translation_box').val('')
)


FishLang.Router.map ->
  @resource "sentences", ->
    @resource "sentence",
      path: ":sentence_id", ->

