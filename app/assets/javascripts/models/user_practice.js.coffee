FishLang.UserPractice = DS.Model.extend(
  error_count: DS.attr("integer")

  sentences: DS.hasMany('FishLang.Sentence')
)
