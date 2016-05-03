class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question
  before_action :find_and_authorize_answer, only: :destroy

  include QuestionsAnswersHelper
    helper_method :user_like

  def create
    answer_params     = params.require(:answer).permit(:body)
    @answer           = Answer.new answer_params
    @answer.question  = @question
    @answer.user      = current_user
    respond_to do |format|
      if @answer.save
        AnswersMailer.notify_question_owner(@answer).deliver_later
        format.html { redirect_to question_path(@question), notice: "Thanks for answering!" }
        format.js { render :create_success }
      else
        flash.now[:alert] = "There was an error saving your answer..."
        format.html { render "/questions/show" }
        format.js { render :create_failure }
      end
    end
  end


  def destroy
    @answer.destroy
    respond_to do |format|
      format.html {redirect_to question_path(@question), notice: "Answer deleted!"}
      format.js { render }
    end
  end

private
  def find_question
    @question = Question.find params[:question_id]
  end

  def find_and_authorize_answer
    @answer = @question.answers.find params[:id]
    # Head will stop the HTTP request and send a response code depending on the symbol (first argument) that you pass in.
    head :unauthorized unless (can? :destroy, @answer) || (can? :manage, @answer)
  end


end
