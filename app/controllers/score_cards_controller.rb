class ScoreCardsController < ApplicationController
  
  def create
    @student = Student.find(params[:score_card][:student_id])
    current_user.scores!(@student, params[:score_card])
    redirect_to :back
  end
end
