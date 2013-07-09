ActiveRecord::Base.connection.execute("TRUNCATE TABLE categories")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE lessons")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE practices")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentences")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_translations")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_reports")


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


l2_1 = Lesson.create(:category => c2, :name => 'Present')
l2_2 = Lesson.create(:category => c2, :name => 'Present Perfect')
l2_3 = Lesson.create(:category => c2, :name => 'Imperfect')
l2_4 = Lesson.create(:category => c2, :name => 'Past Perfect - Pluperfect')
l2_5 = Lesson.create(:category => c2, :name => 'Future')
l2_6 = Lesson.create(:category => c2, :name => 'Future Perfect')


l3_1 = Lesson.create(:category => c3, :name => 'Affirmative Imperative')
l3_2 = Lesson.create(:category => c3, :name => 'Negative Commands')





# practices
p1 = Practice.create(:lesson => l1, :name => 'Practice 1')


# sentences
s1 = Sentence.create(:practice => p1, :verb => 'abrir', :subject => "puedo abrir la puerta")
s2 = Sentence.create(:practice => p1, :verb => 'pasar', :subject => "tú pasas la calle")
s3 = Sentence.create(:practice => p1, :verb => 'terminar', :subject => "la película termina")
s4 = Sentence.create(:practice => p1, :verb => 'empezar', :subject => "empiezo caminar")
s5 = Sentence.create(:practice => p1, :verb => 'dar', :subject => "te doy el libro")
s6 = Sentence.create(:practice => p1, :verb => 'usar', :subject => "él usa el computador")
s7 = Sentence.create(:practice => p1, :verb => 'perder', :subject => "el hombre pierde la llave")
s8 = Sentence.create(:practice => p1, :verb => 'saber', :subject => "tú sabes leer el libro")
s9 = Sentence.create(:practice => p1, :verb => 'correr', :subject => "tú corres en la playa")
s10 = Sentence.create(:practice => p1, :verb => 'querer', :subject => "mi hermano quiere un libro")



# sentence translations
SentenceTranslation.create(:sentence => s1, :subject => "I can open the door")
SentenceTranslation.create(:sentence => s2, :subject => "You pass the street")
SentenceTranslation.create(:sentence => s3, :subject => "The movie ends")
SentenceTranslation.create(:sentence => s4, :subject => "I start to walk")
SentenceTranslation.create(:sentence => s5, :subject => "I give the book to you")
SentenceTranslation.create(:sentence => s5, :subject => "I give you the book")

SentenceTranslation.create(:sentence => s6, :subject => "He uses the computer")
SentenceTranslation.create(:sentence => s7, :subject => "The man loses the key")
SentenceTranslation.create(:sentence => s8, :subject => "You know how to read the book")
SentenceTranslation.create(:sentence => s9, :subject => "you run on the beach")
SentenceTranslation.create(:sentence => s10, :subject => "my brother wants a book")