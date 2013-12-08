class Attendance < ActiveRecord::Base
  belongs_to :dropoff, class_name: "Parent"
  belongs_to :pickup, class_name: "Parent"
  belongs_to :student
end
