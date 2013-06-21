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


FishLang.SentencesRoute = Ember.Route.extend(
  model: ->
    FishLang.Sentence.find()
)

FishLang.SentencesController = Ember.ArrayController.extend(
  sortProperties: [ "id" ]
  sortAscending: false
  filteredContent: (->
    @get("arrangedContent")
  ).property("arrangedContent.@each")
)

FishLang.SentenceController = Ember.ObjectController.extend(
  check: ->
    @get('store').commit()
)



FishLang.Router.map ->
  @resource "sentences", ->
    @resource "sentence",
      path: ":sentence_id", ->
        @route "check",
          path: "check"
