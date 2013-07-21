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
      yo = "yo ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.yo}"
      tu = "tú ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.tu}"
      el = "él ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.el}"
      ella = "ella ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.ella}"
      usted = "usted ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.usted}"
      nosotros = "nosotros ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.nosotros}"
      nosotras = "nosotras ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.nosotras}"
      vosotros = "vosotros ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.vosotros}"
      vosotras = "vosotras ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.vosotras}"
      ellos = "ellos ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.ellos}"
      ellas = "ellas ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.ellas}"
      ustedes = "ustedes ((no )?((lo)|(no)|(la)|(te)|(me)))? #{verb_tense.ustedes}"

      pattern_2 = "((#{yo})|(#{tu})|(#{el})|(#{ella})|(#{usted})|(#{nosotros})|(#{nosotras})|(#{vosotros})|(#{vosotras})|(#{ellos})|(#{ellas})|(#{ustedes}))"

    end


    def _reorganize(str)
      str = str.downcase.strip.squeeze(' ')
      return str if verb_tense.nil?

      str = _build_string(str, _pattern_1(verb_tense))
      str = _build_string(str, _pattern_2(verb_tense))
      # str = _build_string(str, _pattern_3(verb_tense))
    end
end