class CreateStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :students do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :surname, null: false
      t.references :classroom, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.timestamps
    end
  end
end
