#FishLang.Router.map (match)->
  # match('/').to('index')


FishLang.Router.map ->
  @resource "lessons", ->
    @resource "lesson",
      path: ":lesson_id", ->

  @resource "sentences", ->
    @resource "sentence",
      path: ":sentence_id", ->

