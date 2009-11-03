require 'msn/msn'
namespace :botmsn do
	
	desc "MSN bot"
	
     task :startbot => :environment do
     #abertura do msn
	

    email = 'ponto@planobe.com.br'
    password = '123456'

    puts "Signing in... please wait."

    # create a new MSN connection
    msnsock = MSNConnection.new(email, password)

    # connect events
    msnsock.signed_in = lambda { puts "Signed in"
	    msnsock.change_nickname "ROBO DO JEAN(BETA) - Me chamem se precisarem :)"
    }

# display updated buddy, show full contact list
msnsock.buddy_update = lambda {|oldcontact, contact|
	puts "Status Atualizador: #{contact.email} (status: #{oldcontact.status.name} -> #{contact.status.name})"
	puts oldcontact.status.name
	puts contact.status.name
	
  if contact.status.name != oldcontact.status.name
		
	func = Funcionario.find_by_email(contact.email)
     if func.nil? == false
		puts func.nome
	
	
	    if contact.status.name == "Out To Lunch"
		    puts "Bom Almoco. Ponto Marcado! Para desmarcar envie a mensagem !desmarcar"
		    func.marcar_ponto("SaidaAlmoco")
		end
	
	    if oldcontact.status.name == "Out To Lunch"
		    puts "Retorno do Almoco. Ponto Marcado! Para desmarcar envie a mensagem !desmarcar"
		    func.marcar_ponto("RetornoAlmoco")
	    end
	
	    if contact.status.name == "Offline"
	    	puts "Ponto de Saída Marcado! Para desmarcar envie a mensagem !desmarcar"
	    	func.marcar_ponto("SaidaDia")
	    end
	
	    if oldcontact.status.name == "Offline"
		    puts "Ponto de Entrada Marcado! Bom Dia! Para desmarcar envie a mensagem !desmarcar"
	        func.marcar_ponto("EntradaDia")
	    end
    end
    
  end
	
	puts "Contact list:"
	msnsock.contactlists["FL"].list.each {|email, contact|
		puts " - #{email}: #{contact.status.name}" if contact.status.name != "Offline"
	}
}

msnsock.new_chat_session = lambda {|tag, session|
	puts "New chat session request. Tag: #{tag}"
	# chat sessions have events too!
	session.message_received = lambda {|sender, message|
		puts sender + " says: " + message
		# just for fun ;-) The possibilities are endless...
		case message
		when /^quit$/
			session.say "\n c ta de brinks neh? quer fechar o ponto pra q? hahahaha (6)"
		when /^Hello$/
			session.say "\n Hello, Good Morning!"
		when /^help/i
			session.say "\n Comandos suportados:\n help - Exibe esta ajuda.\n marcar - Marca atual horario em seu cartao de ponto.\n desmarcar - Desmarca ultimo horario preenchido do dia(menos o de entrada)\n ultimo - Mostra o ultimo horario marcado \n hoje - Mostra os horarios de hoje \n quit - FECHA o ponto :|"
		when /^marcar/
			func = Funcionario.find_by_email(sender)
			if func.nil? == false
		      puts func.nome
			  func.marcar_ponto("PontoManual")
			  session.say "\n Horario registrado com sucesso.\n Tenha um otimo dia!\n :-)"
			end 
		when /^desmarcar/
			func = Funcionario.find_by_email(sender)
			if func.nil? == false
		      puts func.nome
			  func.desmarcar_ponto
			  session.say "\n Ultimo Horario desmarcado com sucesso.\n Nao se esqueca de marcar o horario correto\n :-)"
		    end
		when /^ultimo/
			func = Funcionario.find_by_email(sender)
			if func.nil? == false
		      puts func.nome
			  session.say func.ultima_marcacao
			end 
		when /^hoje/
			func = Funcionario.find_by_email(sender)
			if func.nil? == false
		      puts func.nome
			  session.say func.horarios_dia
			end
		when /^b.o.z.o/
			session.say "http://snowflakessociety.zip.net/images/Bozo2004.gif"
 		when /^WTF?/
		  session.say "q?/?/? cmofas?//?/?/ hahahaha"
		when /^/
			session.say "\n Nao entendi!\n\n Palavras que eu entendo:\n help - Exibe esta ajuda.\n marcar - Marca atual horario em seu cartao de ponto.\n desmarcar - Desmarca ultimo horario preenchido do dia(menos o de entrada)\n ultimo - Mostra o ultimo horario marcado \n hoje - Mostra os horarios de hoje \n quit - FECHA o ponto :|"
		end
	}

	session.participants_updated = lambda {
		puts "Participants in '#{tag}': " + session.participants.list.to_s
	}
	
	session.start
}

# start signing in!
msnsock.start

while true
	sleep 1
end


end

end
	
