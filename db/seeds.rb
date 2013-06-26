ActiveRecord::Base.connection.execute("TRUNCATE TABLE lessons")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE practices")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE verbs")

ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentences")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_translations")


# Lessons
l1 = Lesson.create(:name => 'Present')
l2 = Lesson.create(:name => 'Present Perfect')
l3 = Lesson.create(:name => 'Imperfect')
l4 = Lesson.create(:name => 'Preterite')
l5 = Lesson.create(:name => 'Past Perfect - Pluperfect')
l6 = Lesson.create(:name => 'Future')
l7 = Lesson.create(:name => 'Future Perfect')
l8 = Lesson.create(:name => 'Condicional')
l9 = Lesson.create(:name => 'Conditional Perfect')
l10 = Lesson.create(:name => 'Preterite Perfect')


# practices
p1 = Practice.create(:lesson => l1, :name => 'Practice 1')
p2 = Practice.create(:lesson => l1, :name => 'Practice 2')

# practice verbs
v1 = Verb.create(:practice => p1, :name => 'ser')
v2 = Verb.create(:practice => p1, :name => 'estar')


# sentences
s1 = Sentence.create(:practice => p1, :subject => "Sí, estoy cansada")
s2 = Sentence.create(:practice => p1, :subject => "él es muy interesante")
s3 = Sentence.create(:practice => p1, :subject => "eres feliz")
s4 = Sentence.create(:practice => p1, :subject => "mañana es bien")


# sentence translations
SentenceTranslation.create(:sentence => s1, :subject => "Yes, I am tired")
SentenceTranslation.create(:sentence => s2, :subject => "he is very interesting")
SentenceTranslation.create(:sentence => s3, :subject => "you are happy")
SentenceTranslation.create(:sentence => s4, :subject => "tomorrow is fine")