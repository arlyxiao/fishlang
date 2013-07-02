FishLang.SentenceTranslation = DS.Model.extend(
  subject: DS.attr("string")

  sentence: DS.belongsTo('FishLang.Sentence')
)