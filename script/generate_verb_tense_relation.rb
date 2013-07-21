def make_relation_with_sentence
  Sentence.all.each do |s|
    lesson_id = s.practice.lesson.id

    verb_name = s.verb
    verb_name = 'poder' if s.practice.name.match(/Infinitive/)

    verb_tense = VerbTense.where(:name => verb_name, :lesson_id => lesson_id).first
    next if verb_tense.nil?

    s.verb_tense = verb_tense
    s.save
    p s
  end
end

make_relation_with_sentence