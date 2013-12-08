class Attendance < ActiveRecord::Base
  belongs_to :dropoff, class_name: "Parent"
  belongs_to :pickup, class_name: "Parent"
  belongs_to :student
  belongs_to :subject
  
  def start_time
    pickup_time
  end
end
