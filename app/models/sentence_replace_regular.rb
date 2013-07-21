module SentenceReplaceRegular
  
  private
    def _build_string(str, pattern)
      match_words = str[/#{pattern}/]
      return str if match_words.nil?

      replace_words = match_words.split(' ')[1..-1]

      replace_str = ''
      replace_words.each do |w|
        replace_str = replace_str + w + ' '
      end

      str.sub( %r{#{pattern}}, replace_str.strip ).downcase.strip
    end

    def _pattern_1(verb_tense)
      yo = "yo #{verb_tense.yo}"
      tu = "tú #{verb_tense.tu}"
      el = "él #{verb_tense.el}"
      ella = "ella #{verb_tense.ella}"
      usted = "usted #{verb_tense.usted}"
      nosotros = "nosotros #{verb_tense.nosotros}"
      nosotras = "nosotras #{verb_tense.nosotras}"
      vosotros = "vosotros #{verb_tense.vosotros}"
      vosotras = "vosotras #{verb_tense.vosotras}"
      ellos = "ellos #{verb_tense.ellos}"
      ellas = "ellas #{verb_tense.ellas}"
      ustedes = "ustedes #{verb_tense.ustedes}"

      pattern_1 = "((#{yo})|(#{tu})|(#{el})|(#{ella})|(#{usted})|(#{nosotros})|(#{nosotras})|(#{vosotros})|(#{vosotras})|(#{ellos})|(#{ellas})|(#{ustedes}))"
    end

    def _pattern_2(verb_tense)
      yo = "yo no #{verb_tense.yo}"
      tu = "tú no #{verb_tense.tu}"
      el = "él no #{verb_tense.el}"
      ella = "ella no #{verb_tense.ella}"
      usted = "usted no #{verb_tense.usted}"
      nosotros = "nosotros no #{verb_tense.nosotros}"
      nosotras = "nosotras no #{verb_tense.nosotras}"
      vosotros = "vosotros no #{verb_tense.vosotros}"
      vosotras = "vosotras no #{verb_tense.vosotras}"
      ellos = "ellos no #{verb_tense.ellos}"
      ellas = "ellas no #{verb_tense.ellas}"
      ustedes = "ustedes no #{verb_tense.ustedes}"

      pattern_2 = "((#{yo})|(#{tu})|(#{el})|(#{ella})|(#{usted})|(#{nosotros})|(#{nosotras})|(#{vosotros})|(#{vosotras})|(#{ellos})|(#{ellas})|(#{ustedes}))"

    end


    def _pattern_3(verb_tense)
      yo = "yo lo #{verb_tense.yo}"
      tu = "tú lo #{verb_tense.tu}"
      el = "él lo #{verb_tense.el}"
      ella = "ella lo #{verb_tense.ella}"
      usted = "usted lo #{verb_tense.usted}"
      nosotros = "nosotros lo #{verb_tense.nosotros}"
      nosotras = "nosotras lo #{verb_tense.nosotras}"
      vosotros = "vosotros lo #{verb_tense.vosotros}"
      vosotras = "vosotras lo #{verb_tense.vosotras}"
      ellos = "ellos lo #{verb_tense.ellos}"
      ellas = "ellas lo #{verb_tense.ellas}"
      ustedes = "ustedes lo #{verb_tense.ustedes}"

      pattern_3 = "((#{yo})|(#{tu})|(#{el})|(#{ella})|(#{usted})|(#{nosotros})|(#{nosotras})|(#{vosotros})|(#{vosotras})|(#{ellos})|(#{ellas})|(#{ustedes}))"

    end

    def _reorganize(str)
      str = str.downcase.strip.squeeze(' ')
      return str if verb_tense.nil?

      str = _build_string(str, _pattern_1(verb_tense))
      str = _build_string(str, _pattern_2(verb_tense))
      str = _build_string(str, _pattern_3(verb_tense))
    end
end