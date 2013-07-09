FishLang.UserPractice = DS.Model.extend(
  error_count: DS.attr("string")

  sentences: DS.hasMany('FishLang.Sentence')
)
