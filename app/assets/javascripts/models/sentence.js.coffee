FishLang.Sentence = DS.Model.extend(
  subject: DS.attr("string")

  practice: DS.belongsTo('FishLang.Practice')
)

DS.RESTAdapter.map 'FishLang.Sentence',
  practice: { embedded: 'load' }