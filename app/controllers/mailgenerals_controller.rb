class MailgeneralsController < ApplicationController


	def index 

	end
    
    def new

    	@mailgeneral=Mailgeneral.new

	end

	def create

    @mailgenerals = Mailgeneral.new(author_params)


    
    @mailgenerals.mailhtml = params[:mailgeneral][:mailhtml] 
    @mailgenerals.titre = params[:mailgeneral][:titre]  # on reccupere le nom du form
    @mailgenerals.body = params[:mailgeneral][:body]
    @mailgenerals.envoigeneral = params[:mailgeneral][:envoigeneral]
    @mailgenerals.type_mail = params[:mailgeneral][:type_mail]
    @mailgenerals.maildestinataire = params[:mailgeneral][:maildestinataire] 
    @mailgenerals.grade1 = params[:id_invitation1]
    @mailgenerals.grade2 = params[:id_invitation2]
    @mailgenerals.grade3 = params[:id_invitation3]
    @mailgenerals.declenchement = true
    @mailgenerals.save


    @destinataire=params[:mailgeneral][:maildestinataire]
    @destinataire=@destinataire.strip
    @author=Author.new
    @author=Author.all
    @invitations=Invitation.all



    


    limite_blackliste = 2  # taux de point negatif pour etre blacklisté
    @ville="Paris"



			   	     


    redirect_to mailgenerals_path  
  


	end


	def author_params
      params.require(:mailgeneral).permit(:titre, :body, :password, :envoigeneral, :maildestinataire, :mailhtml, :type_mail)
    end
 



end
