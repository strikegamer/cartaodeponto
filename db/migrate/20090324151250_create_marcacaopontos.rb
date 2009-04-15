class CreateMarcacaopontos < ActiveRecord::Migration
  def self.up
    create_table :marcacaopontos do |t|
      t.references :funcionario
      t.date :data
      t.datetime :hora1
      t.datetime :hora2
      t.datetime :hora3
      t.datetime :hora4
      t.timestamps
    end
  end

  def self.down
    drop_table :marcacaopontos
  end
end
