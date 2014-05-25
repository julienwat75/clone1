class InvitationsController < ApplicationController


before_filter :zero_authors_or_authenticated, except: [:index,:show, :destroy]	 

skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }



 



def zero_authors_or_authenticated
  unless Invitation.count == 0 || current_user
    redirect_to login_path
    return false
  end
end


def index



@invitations=Invitation.all 





end


def new
  
  @invitations = Invitation.new

  @partenaires = Partenaire.all
  
end

def show

   @pagesysteme=Pagesysteme.new
  

  token=params[:token]

   @a=Author.find_by token:token

   if @a

     auto_login(@a)# login without credentials
     
   end 

	 @invitation=Invitation.find(params[:id])


   @multidate = Multidate.new
   @multidate.invitation_id = @invitation.id

   @tout=Multidate.all

  

  
   render :layout => false



	end


def create              # le submit va chercher la methode create

	adresse1= params[:adresse]


  

  @invitations = Invitation.new(profil_params)

  @partenaire = Partenaire.find_by_id(adresse1)

 
  @invitations.adresse=@partenaire.nom


  @invitations.vraiadresse=@partenaire.adresse

  @invitations.emailpartenaire=@partenaire.email





  var = params[:invitation][:dateinvitation]  # on reccupere le nom du form
  heure=params[:heure1]
  minute=params[:minute1]
  seconde="00"
  var3=var + " " + heure + ":" + minute + ":" + seconde 
  
  @invitations.dateinvitation = DateTime.parse(var3)
  @invitations.titre = params[:invitation][:titre]  # on reccupere le nom du form
  @invitations.description = params[:invitation][:description]  # on reccupere le nom du form
  @invitations.avatar = params[:invitation][:avatar]  # on reccupere le nom du form
   @invitations.place = params[:place]
   @invitations.validation = true
  @invitations.author_id =current_user.id

 


  @invitations.save   #on sauvegarde
   redirect_to webmasters_path     # redirection vers l'index

end

def edit

@invitation=Invitation.find(params[:id])
end

def update



  

 

          
  
 
@invitation = Invitation.find params[:id]
#@invitation.update_attributes(validation: 'true')
@invitation.update_attributes(titre: params[:invitation][:titre],description: params[:invitation][:description],vraiadresse: params[:invitation][:vraiadresse])
#@invitation.update_attributes(description: params[:invitation][:description])
#@invitation.update_attributes(avatar: params[:invitation][:avatar])
 #@invitation.update_attributes(avatar: params[:invitation][:datetime])


  @invitation.update_attribute(:envoiemail, true)

  heuremailpartenaire= @invitation.dateinvitation.to_datetime - (30.minutes)
  

  @invitation.update_attribute(:heuremailpartenaire,heuremailpartenaire) 
  

 
 redirect_to webmasters_path 


           
           #binding.pry 
           #raise params.inspect 


     

  end

  def destroy

    

    

    


@invitation=Invitation.find(params[:id])

@invitation.destroy

    respond_to do |format|
      format.html { redirect_to webmasters_url }
      format.json { head :no_content }
    end
  end


  def search

  redirect_to webmasters_path 

  end





def profil_params
    params.require(:invitation).permit(:titre,:description,:avatar,:datetime,:place)
  end





end
