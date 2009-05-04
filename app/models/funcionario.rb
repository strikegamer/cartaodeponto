class Funcionario < ActiveRecord::Base
	has_many :marcacaopontos
	
	def marcar_ponto(tipomarcacao)
		self.marcacaopontos.create(:data => DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day), :hora1 => DateTime.now)
        unless self.save
          self.reload
          ultima_marcacao = self.marcacaopontos.last
          novohorario = DateTime.now
          if ultima_marcacao.hora2.nil?
      	    if tipomarcacao == "SaidaAlmoco" || tipomarcacao == "PontoManual"
      	      if ultima_marcacao.hora1.strftime("%H:%M") != novohorario.strftime("%H:%M")	
                 ultima_marcacao.hora2 = novohorario
                 ultima_marcacao.save
              end
            end
          elsif ultima_marcacao.hora3.nil?
      	    if tipomarcacao == "RetornoAlmoco" || tipomarcacao == "PontoManual"
      	      if ultima_marcacao.hora2.strftime("%H:%M") != novohorario.strftime("%H:%M")
               ultima_marcacao.hora3 = novohorario
               ultima_marcacao.save
              end
            end
          elsif ultima_marcacao.hora4.nil?
      	    if tipomarcacao == "SaidaDia" || tipomarcacao == "PontoManual"
      	      if ultima_marcacao.hora3.strftime("%H:%M") != novohorario.strftime("%H:%M")
                ultima_marcacao.hora4 = novohorario
                ultima_marcacao.save
              end
            end
          end
       end
    end
    
    
    def desmarcar_ponto
		  ultima_marcacao = self.marcacaopontos.last
          if ultima_marcacao.hora4.nil? == false
      	      ultima_marcacao.hora4 = nil
              ultima_marcacao.save  
          elsif ultima_marcacao.hora3.nil? == false
      	      ultima_marcacao.hora3 = nil
              ultima_marcacao.save  
          elsif ultima_marcacao.hora2.nil? == false
      	      ultima_marcacao.hora2 = nil
              ultima_marcacao.save  
          end    
    end
    
     def ultima_marcacao
     	  ultima_marcacao = self.marcacaopontos.last
          if ultima_marcacao.hora4.nil? == false
      	      return ultima_marcacao.hora4.strftime("%d/%m/%Y %H:%M")
         elsif ultima_marcacao.hora3.nil? == false
      	      return ultima_marcacao.hora3.strftime("%d/%m/%Y %H:%M")
          elsif ultima_marcacao.hora2.nil? == false
      	     return ultima_marcacao.hora2.strftime("%d/%m/%Y %H:%M")
      	  elsif ultima_marcacao.hora1.nil? == false
      	     return ultima_marcacao.hora1.strftime("%d/%m/%Y %H:%M")
          end 
    end
    
    def horarios_dia
    	 retorno = "Horarios de hoje:\n"    	
    	  hoje = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day)
		  marcacao_hoje = self.marcacaopontos.find_by_data(hoje)
		  if marcacao_hoje.nil? ==false
            if marcacao_hoje.hora1.nil? == false
               hora1 = 	marcacao_hoje.hora1.strftime('%d/%m/%Y %H:%M')
      	       retorno = retorno + "Chegada: " + hora1 + "\n"
            end     
            if marcacao_hoje.hora2.nil? == false
      	       hora2 = marcacao_hoje.hora2.strftime('%d/%m/%Y %H:%M')
      	       retorno = retorno + "Saida Almoco: " + hora2 + "\n"
            end      
            if marcacao_hoje.hora3.nil? == false
      	       hora3 = marcacao_hoje.hora3.strftime('%d/%m/%Y %H:%M')
      	       retorno = retorno + "Retorno Almoco: " + hora3 + "\n"
            end      
            if marcacao_hoje.hora4.nil? == false
      	       hora4 = marcacao_hoje.hora4.strftime('%d/%m/%Y %H:%M')
      	       retorno = retorno + "Saida: " + hora4 + "\n"
            end      
            return retorno
       else
            return "nada carai"	
  	   end
    end
    
    
    def formathora(hora)
  		if hora.nil? == true
  			return ""
  		else
  			return hora.strftime("%H:%M")
  		end
  	end
  	
  	def mesbr(mes)
  	  mes = mes.to_s
  	  result = nil
  	  if mes == "1"
    	   result = "Janeiro"
  	  end
    	if mes == "2"
    	   result = "Fevereiro"
    	end   
      if mes == "3"
     	   result = "Março"
   	  end
      if mes == "4"
     	   result = "Abril"
     	end   
      if mes == "5"
     	   result = "Maio"
   	  end
      if mes == "6"
     	   result = "Junho"
   	  end
      if mes == "7"
     	   result = "Julho"
   	  end
      if mes == "8"
     	   result = "Agosto"
   	  end
      if mes == "9"
     	   result = "Setembro"
   	  end
      if mes == "10"
     	   result = "Outubro"
   	  end
      if mes == "11"
     	   result = "Novembro"
   	  end
      if mes == "12"
     	   result = "Dezembro"
    	end
    	return result
	  end  	
  	def hojeporextenso
  	 mes = mesbr(Time.now.month.to_s)  	 
  	 return Time.now.day.to_s + " de " + mes + " de " + Time.now.year.to_s  	  
	  end

    def horastrabalhadasdia(data)
      # debugger
      begin 
       marcacaopontos = self.marcacaopontos.find(:all,:conditions => ["(data = ?)", data.to_datetime])
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

      def horastrabalhadasnomes(mes,ano)
        year = ano.to_i   
        month = mes.to_i   
        first = Date.civil(year, month, 1)   
        last = Date.civil(year, month, -1)  
        @marcacaopontos = self.marcacaopontos.find(:all,:conditions => ["(data BETWEEN ? AND ?)", first.to_datetime, last.to_datetime],:order => 'data')

        if @marcacaopontos.size > 0
           totalgeralminutos = 0
           for marcacaoponto in @marcacaopontos
             begin
               horadia = horastrabalhadasdia(marcacaoponto.data)
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
