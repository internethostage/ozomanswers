class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question         = Question.find params[:question_id]
    answer_params     = params.require(:answer).permit(:body)
    @answer           = Answer.new answer_params
    @answer.question  = @question
    @answer.user      = current_user
    if @answer.save
      redirect_to question_path(@question), notice: "Thanks for answering!"
    else
      flash[:alert] = "not saved"
      render "/questions/show"
    end
  end


  def destroy
    question = Question.find params[:question_id]
    answer = question.answers.find params[:id]
    answer.destroy
    redirect_to question_path(question), notice: "Answer deleted!"
  end


end
