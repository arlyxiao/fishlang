ActiveRecord::Base.connection.execute("TRUNCATE TABLE sentences")


Sentence.create(:subject => "Sí, estoy cansada")
Sentence.create(:subject => "hola")
Sentence.create(:subject => "adiós")
Sentence.create(:subject => "él es muy interesante")