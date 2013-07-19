ActiveRecord::Base.connection.execute("TRUNCATE TABLE users")


$dir = ARGV[0]


def save_users
	path = File.join($dir, 'users.yaml')
	rows = YAML.load_file(path)
	rows.each do |r|
		user = User.create!(
			{
				email: r['email'], 
				name: r['name'], 
				password: r['password'], 
				password_confirmation: r['password_confirmation'] 
			}
		)
		user.update_attribute :admin, true
	end
end


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


save_users

import

