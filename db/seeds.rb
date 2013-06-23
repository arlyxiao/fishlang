ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentences")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_translations")


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




s1 = Sentence.create(:lesson => l1, :subject => "Sí, estoy cansada")
s2 = Sentence.create(:lesson => l1, :subject => "él es muy interesante")
s3 = Sentence.create(:lesson => l1, :subject => "eres feliz")
s4 = Sentence.create(:lesson => l1, :subject => "mañana es bien")



SentenceTranslation.create(:sentence => s1, :subject => "Yes, I am tired")
SentenceTranslation.create(:sentence => s2, :subject => "he is very interesting")
SentenceTranslation.create(:sentence => s3, :subject => "you are happy")
SentenceTranslation.create(:sentence => s4, :subject => "tomorrow is fine")