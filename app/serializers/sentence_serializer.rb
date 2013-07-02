class SentenceSerializer < ActiveModel::Serializer
  attributes :id, :subject, :practice, :translations
end
