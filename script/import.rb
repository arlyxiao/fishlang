$dir = ARGV[0]


def import
  Category.all.each do |c|

    c.lessons.each do |l|

      lesson_path = File.join($dir, c.name, l.name, '*.yaml')
      practice_dirs = Dir[lesson_path]


      practice_dirs.each do |practice_path|
        row = YAML.load_file(practice_path)
        practice = Practice.create(:lesson => l, :name => row[:name])

        row[:sentences].each do |s|
          sentence = Sentence.create(:practice => practice, :subject => s[:subject], :verb => s[:verb])
          p sentence
          s[:translations].each do |t|
            SentenceTranslation.create(:sentence => sentence, :subject => t)
          end

        end

      end

    end

  end

end

ActiveRecord::Base.connection.execute("TRUNCATE TABLE categories")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE lessons")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE practices")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentences")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_translations")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_reports")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE user_exercises")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_failures")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE lesson_points")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE practice_points")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_failure_points")



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


import

