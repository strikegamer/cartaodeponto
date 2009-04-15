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
  
	
	
end
