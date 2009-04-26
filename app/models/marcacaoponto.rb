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
	
	
  def horastrabalhadasdia(funcionario_id,data)
    # debugger
    begin 
     funcionario = Funcionario.find(funcionario_id)
     marcacaopontos = funcionario.marcacaopontos.find(:all,:conditions => ["(data = ?)", data.to_datetime])
     hora1 = convertparaminutos(marcacaopontos[0].hora1)
     hora2 = convertparaminutos(marcacaopontos[0].hora2)
     hora3 = convertparaminutos(marcacaopontos[0].hora3)
     hora4 = convertparaminutos(marcacaopontos[0].hora4)
       
     parcial1 = hora2 - hora1
     horaparcial1 =  (parcial1 / 60).to_i
     minutosparcial1 =  (parcial1 % 60.to_f).to_i
     
     parcial2 = hora4 - hora3
     horaparcial2 =  (parcial2 / 60).to_i
     minutosparcial2 =  (parcial2 % 60.to_f).to_i
     
     total1 = horaparcial1 * 60
     total1 = total1 + minutosparcial1
     
     total2 = horaparcial2 * 60
     total2 = total2 + minutosparcial2
     
     totalgeral = total1 + total2
     
     horatotal = (totalgeral / 60).to_i
     minutostotal = (totalgeral % 60.to_f).to_i
     
     return ("%02d" % horatotal.to_s) + ":" + ("%02d" % minutostotal.to_s)
  
   rescue Exception => exc
     return "Há marcações vazias"
   end  
  end
    
    def horastrabalhadasnomes(funcionario_id,mes,ano)
      year = ano.to_i   
      month = mes.to_i   
      first = Date.civil(year, month, 1)   
      last = Date.civil(year, month, -1)  
      funcionario = Funcionario.find(funcionario_id) 
      @marcacaopontos = funcionario.marcacaopontos.find(:all,:conditions => ["(data BETWEEN ? AND ?)", first.to_datetime, last.to_datetime],:order => 'data')
      
      if @marcacaopontos.size > 0
      
         totalgeralminutos = 0
      
      
         for marcacaoponto in @marcacaopontos
           begin
             horadia = horastrabalhadasdia(funcionario.id,marcacaoponto.data)
             totalminutos = horadia.split(':')[0].to_i
             totalminutos = totalminutos * 60
             totalminutos = totalminutos + horadia.split(':')[1].to_i
             totalgeralminutos = totalgeralminutos + totalminutos
           rescue 
           end
         end
      
         if totalgeralminutos > 0
             horatotal = (totalgeralminutos / 60).to_i
             minutostotal = (totalgeralminutos % 60.to_f).to_i
             return ("%02d" % horatotal.to_s) + ":" + ("%02d" % minutostotal.to_s)
         else
           return "não encontrados dias trabalhados neste mês"
         end
      else
          return "não encontrados dias trabalhados neste mês" 
      end     
  end
    
  def convertparaminutos(data)
      result = data.hour * 60
      result = result + data.min
      return result
  end
		
end
