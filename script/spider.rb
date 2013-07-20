require 'open-uri'

ActiveRecord::Base.connection.execute("TRUNCATE TABLE verb_tenses")


def fetch(verb)
  url = "http://www.123teachme.com/spanish_verb_conjugation/#{verb}"
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



Sentence.select("DISTINCT(verb)").first(2).each do |s|
  tenses = fetch(s.verb)
  tense_data = []

  tense_data << tenses[0, 89]
  tense_data << tenses[89, 138]
  tense_data << tenses[138, 161]

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
            :yo => tenses[index + 2],
            :tu => tenses[index + 3],
            :el => tenses[index + 4],
            :ella => tenses[index + 4],
            :usted => tenses[index + 4],
            :nosotros => tenses[index + 5],
            :nosotras => tenses[index + 5],
            :vosotros => tenses[index + 6],
            :vosotras => tenses[index + 6],
            :ellos => tenses[index + 7],
            :ellas => tenses[index + 7],
            :ustedes => tenses[index + 7]
          )
          # p verb_tense
          # p '------------'
        end

      end
      
    end

    k = k + 1
  end

end
