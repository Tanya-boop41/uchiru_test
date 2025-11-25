class CreateClassrooms < ActiveRecord::Migration[8.1]
  def change
    create_table :classrooms do |t|
      t.integer :number, null: false
      t.string :letter, null: false
      t.references :school, null: false, foreign_key: true
      t.integer :students_count, null: false, default: 0
      t.timestamps
    end
  end
end
