ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentences")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_translations")


Lesson.create(:name => 'Present')
Lesson.create(:name => 'Present Perfect')
Lesson.create(:name => 'Imperfect')
Lesson.create(:name => 'Preterite')
Lesson.create(:name => 'Past Perfect - Pluperfect')
Lesson.create(:name => 'Future')
Lesson.create(:name => 'Future Perfect')
Lesson.create(:name => 'Condicional')
Lesson.create(:name => 'Conditional Perfect')
Lesson.create(:name => 'Preterite Perfect')




s1 = Sentence.create(:subject => "Sí, estoy cansada")
s2 = Sentence.create(:subject => "hola")
s3 = Sentence.create(:subject => "adiós")
s4 = Sentence.create(:subject => "él es muy interesante")

SentenceTranslation.create(:sentence => s1, :subject => "Yes, I am tired")
SentenceTranslation.create(:sentence => s2, :subject => "hello")
SentenceTranslation.create(:sentence => s3, :subject => "bye")
SentenceTranslation.create(:sentence => s4, :subject => "he is very interesting")