class Attendance < ActiveRecord::Base
  belongs_to :dropoff, class_name: "User"
  belongs_to :pickup, class_name: "User"
  belongs_to :student
  belongs_to :subject
  
  def start_time
    dropoff_time
  end
end
