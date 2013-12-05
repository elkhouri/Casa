class Student < User
  has_many :tutorages
  has_many :volunteers, through: :tutorages
end
