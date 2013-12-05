class Tutorage < ActiveRecord::Base
  belongs_to :volunteer
  belongs_to :student
  validates :volunteer_id, presence: true
  validates :student_id, presence: true
end
