class AddIndexToQuestionsTitle < ActiveRecord::Migration
  def change
    #this adds an index to the questions and title column
    add_index :questions, :title
  end
end
