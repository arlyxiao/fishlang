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


ActiveRecord::Base.connection.execute("TRUNCATE TABLE users")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE practices")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentences")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_translations")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_reports")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE user_exercises")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_failures")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE lesson_points")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE practice_points")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentence_failure_points")


import

