
def parse_spider_error_file
  contents = File.read('spider_error_file')
  rows = contents.split('-----')


  rows.each do |r|
    r = JSON.parse(r)
    p JSON.parse(r['verb_tense'])
    p JSON.parse(r['messages'])
    p '----'
  end
end


def parse_tense_error_file
  contents = File.read('tense_error_file')
  rows = contents.split('-----')


  rows.each do |r|
    r = JSON.parse(r)
    p r
    p '----'
    p r.length
  end
end


def unusual_verbs

  Sentence.select("DISTINCT(verb)").each do |s|

    count = VerbTense.where(:name => s.verb).count
    p "#{s.verb}, #{count}"  if count < 18

  end

end

unusual_verbs
