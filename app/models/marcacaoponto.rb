class Marcacaoponto < ActiveRecord::Base
	belongs_to :funcionario
	validates_uniqueness_of :data, :scope => "funcionario_id"	
	
end
