$dir = ARGV[0]


def export
  Category.all.each do |c|

    path = File.join($dir, c.name)
    FileUtils.rm_rf(path)
    FileUtils.mkdir path

    c.lessons.each do |l|
      path = File.join($dir, c.name, l.name)
      FileUtils.rm_rf(path)
      FileUtils.mkdir path

      l.practices.each do |p|

        sentences_hash = []
        p.sentences.each do |s|
          row = {
            :subject => s.subject,
            :verb => s.verb,
            :translations => s.translations.map(&:subject)
          }
          sentences_hash << row
        end

        practice_hash = {
          :name => p.name,
          :sentences => sentences_hash
        }

        target_file = File.join(path, "#{p.id}.yaml")
        File.open(target_file, 'w+') {|f| f.write(practice_hash.to_yaml) }

      end

    end

  end

end

export


