class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id #question creator
      t.string :body
      
      t.timestamps
    end
    
    add_index :questions, :user_id
    
  end
end
