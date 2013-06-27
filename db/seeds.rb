ActiveRecord::Base.connection.execute("TRUNCATE TABLE lessons")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE practices")
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


# sentences
s1 = Sentence.create(:practice => p1, :verb => 'abrir', :subject => "puedo abrir la puerta")
s2 = Sentence.create(:practice => p1, :verb => 'pasar', :subject => "tú pasas la calle")
s3 = Sentence.create(:practice => p1, :verb => 'terminar', :subject => "la película termina")
s4 = Sentence.create(:practice => p1, :verb => 'empezar', :subject => "empiezo caminar")


# sentence translations
SentenceTranslation.create(:sentence => s1, :subject => "I can open the door")
SentenceTranslation.create(:sentence => s2, :subject => "You pass the street")
SentenceTranslation.create(:sentence => s3, :subject => "The movie ends")
SentenceTranslation.create(:sentence => s4, :subject => "I start to walk")