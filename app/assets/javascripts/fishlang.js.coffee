#= require ./store
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates
#= require_tree ./routes
#= require ./router
#= require_self


Fishlang.Store = DS.Store.extend(
  revision: 12
  adapter: "DS.RESTAdapter" # "DS.FixtureAdapter"
)

Fishlang.Sentence = DS.Model.extend(
  content: DS.attr("string")
)


Fishlang.SentencesRoute = Ember.Route.extend(
  model: ->
    Fishlang.Sentence.find()
)

Fishlang.SentencesController = Ember.ArrayController.extend(
  juston: 'ok'
  sortProperties: [ "id" ]
  sortAscending: false
  filteredContent: (->
    content = @get("arrangedContent")
  ).property("arrangedContent.@each")
)

Fishlang.IndexRoute = Ember.Route.extend(redirect: ->
  @transitionTo "sentences"
)


Fishlang.Router.map ->
  @resource "sentences", ->