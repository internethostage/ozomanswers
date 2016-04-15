class Answer < ActiveRecord::Base
  #By having this "belongs_to" in the model we can easily fetch the question for a given answer by running:
  #ans = Answer.find(14)
  #q = ans.question
  #belongs_to assumes that the 'answers' table has a foreign_key called question_id (Rails convention)
  belongs_to :question

  validates :body, presence: true
end
