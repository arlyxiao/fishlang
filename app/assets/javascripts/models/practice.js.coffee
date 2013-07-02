FishLang.Practice = DS.Model.extend(
  name: DS.attr("string")

  sentences: DS.hasMany('FishLang.Sentence')
)
