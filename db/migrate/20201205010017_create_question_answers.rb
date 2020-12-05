class CreateQuestionAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :question_answers do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :question
      t.string :answer

      t.timestamps
    end
  end
end
