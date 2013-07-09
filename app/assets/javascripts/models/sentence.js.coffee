FishLang.Sentence = DS.Model.extend(
  subject: DS.attr("string")

  practice: DS.belongsTo('FishLang.Practice')
  translations: DS.hasMany('FishLang.SentenceTranslation')
)

DS.RESTAdapter.map 'FishLang.Sentence',
  practice: { embedded: 'load' }
  translations: {embedded: 'load'}
