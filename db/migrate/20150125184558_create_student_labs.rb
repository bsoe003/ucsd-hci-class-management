class CreateStudentLabs < ActiveRecord::Migration
  def change
    create_table :student_labs do |t|
      t.integer :student_id
      t.integer :lab_id
      t.boolean :complete, :default=>false
      t.timestamps
    end
  end
end
