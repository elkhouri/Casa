class ScoreCard < ActiveRecord::Base
  belongs_to :student
  belongs_to :volunteer
end
