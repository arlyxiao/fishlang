#FishLang.Router.map (match)->
  # match('/').to('index')


FishLang.Router.map ->
  @resource "practices", ->
    @resource "practice",
      path: ":practice_id", ->

  @resource "sentences", ->
    @resource "sentence",
      path: ":sentence_id", ->

