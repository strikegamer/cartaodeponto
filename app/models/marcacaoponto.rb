class Marcacaoponto < ActiveRecord::Base
	belongs_to :funcionario
	validates_uniqueness_of :data, :scope => "funcionario_id"
	
	def formathora(hora)
		if hora.nil? == true
			return ""
		else
			return hora.strftime("%H:%M")
		end
	end
		
end
