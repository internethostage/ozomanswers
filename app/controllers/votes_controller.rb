class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    vote = Vote.new(is_up: params[:vote][:is_up])
    vote.question = question
    vote.user = current_user

    if vote.save
      redirect_to question, notice: "Voted!"
    else
      redirect_to question, alert: "Can't vote again!"
    end
  end

  def update
    if vote.update(is_up: params[:vote][:is_up])
      redirect_to question, notice: "Vote changed"
    else
      redirect_to question, alert: "Vote wasn't changed"
    end
  end

  def destroy
    vote.destroy
    redirect_to question, alert: "Vote Undone!"
  end

  private

  def vote
    @vote = current_user.votes.find params[:id]
  end

  def question
    @question ||= Question.find params[:question_id]
  end

end
