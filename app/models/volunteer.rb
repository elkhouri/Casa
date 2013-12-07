class Volunteer < User
  has_many :tutorages
  has_many :students, through: :tutorages
  has_many :score_cards
  
  def teach!(student)
    tutorages.create!(student: student)
  end
  
  def teach?(student)
    tutorages.find(student: student)
  end
  
  def scores!(student, score_card)
    score_cards.create!(student: student, engagement: score_card[:engagement],
                        preparedness: score_card[:preparedness], attention: score_card[:attention],
                        overall: score_card[:overall], note: score_card[:note])
  end
end
