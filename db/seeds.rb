ActiveRecord::Base.connection.execute("TRUNCATE TABLE categories")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE lessons")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE practices")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentences")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_translations")

c1 = Category.create(:name => 'Indicative')
c2 = Category.create(:name => 'Subjunctive')
c3 = Category.create(:name => 'Imperative')


# Lessons
l1 = Lesson.create(:category => c1, :name => 'Present')
l2 = Lesson.create(:category => c1, :name => 'Present Perfect')
l3 = Lesson.create(:category => c1, :name => 'Imperfect')
l4 = Lesson.create(:category => c1, :name => 'Preterite')
l5 = Lesson.create(:category => c1, :name => 'Past Perfect - Pluperfect')
l6 = Lesson.create(:category => c1, :name => 'Future')
l7 = Lesson.create(:category => c1, :name => 'Future Perfect')
l8 = Lesson.create(:category => c1, :name => 'Condicional')
l9 = Lesson.create(:category => c1, :name => 'Conditional Perfect')
l10 = Lesson.create(:category => c1, :name => 'Preterite Perfect')


# practices
p1 = Practice.create(:lesson => l1, :name => 'Practice 1')
p2 = Practice.create(:lesson => l1, :name => 'Practice 2')


# sentences
s1 = Sentence.create(:practice => p1, :verb => 'abrir', :subject => "puedo abrir la puerta")
s2 = Sentence.create(:practice => p1, :verb => 'pasar', :subject => "tú pasas la calle")
s3 = Sentence.create(:practice => p1, :verb => 'terminar', :subject => "la película termina")
s4 = Sentence.create(:practice => p1, :verb => 'empezar', :subject => "empiezo caminar")
s5 = Sentence.create(:practice => p1, :verb => 'dar', :subject => "te doy el libro")
s6 = Sentence.create(:practice => p1, :verb => 'usar', :subject => "él usa el computador")
s7 = Sentence.create(:practice => p1, :verb => 'perder', :subject => "el hombre pierde la llave")



# sentence translations
SentenceTranslation.create(:sentence => s1, :subject => "I can open the door")
SentenceTranslation.create(:sentence => s2, :subject => "You pass the street")
SentenceTranslation.create(:sentence => s3, :subject => "The movie ends")
SentenceTranslation.create(:sentence => s4, :subject => "I start to walk")
SentenceTranslation.create(:sentence => s5, :subject => "I give the book to you")
SentenceTranslation.create(:sentence => s6, :subject => "He uses the computer")
SentenceTranslation.create(:sentence => s7, :subject => "The man loses the key")