class QuestionsController < ApplicationController

before_action :authenticate_user!, except: [:index, :show]
#Defining a method as a before action will make it so that rails executes that method before executing the action. This is still within the same request cycle
#You can give the before action method 2 options; :only or :except this will help you limit the action which the find_question method will be executed before
#In this case, before action will only be executed before show edit update and destroy actions.
before_action :find_question, only: [:show, :edit, :update, :destroy]
before_action :authorize_question, only: [:edit, :update, :destroy]

# include QuestionsAnswersHelper
#   helper_method :user_like

  def create
    #method one
    # @question = Question.new
    # @question.title = params[:question][:title]
    # @question.body = params[:question][:body]
    # @question.save

    #method two
    # @question = Question.create({ title: params[:question][:title],
    #                               body: params[:question][:body]})

    # method three
    # @question = Question.create(params[:question])
    # #This will throw a: ActiveModel::ForbiddenAttributesError exception

    # method four Strong Parameters

    @question       = Question.new(question_params)
    @question.user  = current_user
    if @question.save
      flash[:notice] = "Question created!"
      #to change the url and display the page we do
      # Method 1 to do this is redirect_to question_path({id: @question.id})
      # Method 2 a bit simpler
      redirect_to question_path(@question)
    else
      flash.now[:alert] = "Question didn't save!"
      #if the db save fails, it renders the apps/views/questions/new.html.erb because the default in this action is to render app/views/qeuestionscreate.html.erb
      render :new
    end


  end


  #WE receive a request such as : GET /questions/56
  #params[:id] will be '56'
  def show
    @answer = Answer.new
    @list_of_voting_users ||= @question.votes.joins(:user).pluck("users.first_name").join(" ")
    @list_of_liked_users ||= @question.likes.joins(:user).pluck("users.first_name").join(" ")
    respond_to do |format|
      format.html { render }
      format.json { render json: @question.to_json }
      format.xml { render xml: @question.to_xml }
    end
  end


  def new
    # WE define a new "Question" object in order to be able to properly generate a form in Rails
    @question = Question.new
  end

  def index
    @questions = Question.all
    respond_to do |format|
      format.html { render }
      format.json { render json: @questions.select(:id, :title, :view_count) }
    end
  end

  def edit
  end

  def update
    @question.slug = nil
    if @question.update question_params
      redirect_to question_path(@question), notice: "Question updated!"
    else
      flash.now[:alert] = "Question didn't save!"
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Question: #{@question.title} deleted!"
  end

private

  def authorize_question
    redirect_to root_path unless can? :crud, @question
  end

  def find_question
    @question = Question.friendly.find params[:id]
  end

  def question_params
    params.require(:question).permit([:title, :body, :category_id, {tag_ids: []}])
  end

  # def user_like
  #     @user_like ||= @question.like_for(current_user)
  # end
  # helper_method :user_like


end
