class CreateFuncionarios < ActiveRecord::Migration
  def self.up
    create_table :funcionarios do |t|
      t.string :nome
      t.string :email
      t.string :cargo

      t.timestamps
    end
  end

  def self.down
    drop_table :funcionarios
  end
end
