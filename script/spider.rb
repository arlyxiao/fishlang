require 'open-uri'

# ActiveRecord::Base.connection.execute("TRUNCATE TABLE verb_tenses")


File.open("spider_error_file", "w") do |f|
  f << ""
end

File.open("tense_error_file", "w") do |f|
  f << ""
end

def fetch(verb)
  url = "http://www.123teachme.com/spanish_verb_conjugation/#{verb}"
  # url = "http://www.123teachme.com/spanish_verb_conjugation/hablar"
  doc = Nokogiri::HTML(open(url))

  i = 0
  tenses = []
  doc.xpath('//table/tr').each do |row|
    row.xpath('./td').each do |td|

      p "#{i}, #{td.text}"
      tenses << td.text

      i = i + 1

    end
  end

  tenses
end

categories = Category.all
tenses = nil
errors = {}

m = 1
position = 0
Sentence.select("DISTINCT(verb)").each do |s|

  unless VerbTense.where(:name => s.verb).exists?
    sleep(1)
    tenses = fetch(s.verb)
  end

  next if tenses.blank? || tenses.nil?
  tense_data = []

  if tenses[1] == 'inglés'
    position = 2
    tense_data << tenses[0, 89]
    tense_data << tenses[89, 138]
    tense_data << tenses[138, tenses.length]
  end

  if tenses[1] == 'yo'
    position = 1
    tense_data << tenses[0, 78]
    tense_data << tenses[78, 107]
    tense_data << tenses[107, tenses.length]
  end

  if tense_data[0].nil? || tense_data[1].nil? || tense_data[2].nil?
    p tenses
    p '-----'
    File.open("tense_error_file", "a") do |f|
      f << "#{tenses.to_json}-----"
    end
    next
  end

  k = 0
  while k <= 2 do
    lessons = categories[k].lessons
    tenses = tense_data[k]

    lessons.each do |l|

      tenses.each_with_index do |item, index|


        if item.downcase.strip == l.name.downcase.strip

          verb_tense = VerbTense.create(
            :name => s.verb, 
            :lesson_id => l.id,
            :yo => tenses[index + position],
            :tu => tenses[index + position + 1],
            :el => tenses[index + position + 2],
            :ella => tenses[index + position + 2],
            :usted => tenses[index + position + 2],
            :nosotros => tenses[index + position + 3],
            :nosotras => tenses[index + position + 3],
            :vosotros => tenses[index + position + 4],
            :vosotras => tenses[index + position + 4],
            :ellos => tenses[index + position + 5],
            :ellas => tenses[index + position + 5],
            :ustedes => tenses[index + position + 5]
          )
          errors = {
            :verb_tense => verb_tense.to_json,
            :messages => verb_tense.errors.to_json
          }

          unless verb_tense.errors.blank?
            File.open("spider_error_file", "a") do |f|
              f << "#{errors.to_json}-----"
            end
          end

          p m

          m = m + 1 if verb_tense.errors.blank?
          
        end

      end
      
    end

    k = k + 1
  end

end
