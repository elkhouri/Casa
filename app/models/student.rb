class Student < User
  has_many :tutorages
  has_many :volunteers, through: :tutorages
  has_many :score_cards
end
