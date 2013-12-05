class Volunteer < User
  has_many :tutorages
  has_many :students, through: :tutorages
  
  def teach!(student)
    tutorages.create!(student: student)
  end
end
