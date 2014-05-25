class ChargesController < ApplicationController




  before_filter :zero_authors_or_authenticated, except: [:index]  



def zero_authors_or_authenticated
  unless Invitation.count == 0 || current_user
    redirect_to new_author_path
    #redirect_to login_path
    return false
  end
end




  


  def new

     @invitation=Invitation.find(params[:idinvite])

     @tabmulti=@invitation.multidates

     @multi=@tabmulti.find_by_id(params[:idmulti])

end

def index

end

def create


#----------------------- Partie bdd ------------------------------------------------------ 

if current_user.limite_payante 

  #redirect_to "/pages/limite"
  #return false

  end






  @author=current_user
  code1=Invitation.aleatoire
  
  
 @reservations = Reservation.new
 id=params[:idinvitation]
 @invitation=Invitation.find(params[:idinvitation])

  @tabmulti=@invitation.multidates
  @multi=@tabmulti.find_by_id(params[:idmulti])

    
  
  
  places_demander=params[:nombreinvitations]
  places_restante=(@multi.placex.to_i)-(places_demander.to_i)   # on soustrait le nombre de place


  

  if places_restante < 0 

  redirect_to "/pages/epuise"

  else



   @parametre=params
   @info=params[:stripeToken]


  @amount=params[:heure1]


  


  customer = Stripe::Customer.create(
    :email => 'julien_wat@hotmail.fr',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'eur'
    
  )





 
 
#-----laisser commenter meme pendant la remise de la carte bleu ---------------------------

 # rescue Stripe::CardError => e
  #flash[:error] = e.message

   
  #format.html { redirect_to charges_path, :notice => 'Event was successfully upgraded.' }


  #-----------------------------------------------------------------



  
  current_user.update_attribute(:limite_payante, true)

  point = current_user.point_positif
  nouveau_point=point.to_i + 1
  current_user.update_attribute(:point_positif, nouveau_point)



  @multi.update_attribute(:placex, places_restante)


  if @multi.gratuit

  @reservations.gratuit= true

  else
   
    @reservations.gratuit= false
    @reservations.price= @multi.price



  end
 
 
  

 
  @reservations.nombreinvitations=params[:nombreinvitations] 
  @reservations.titre=params[:titre]   # ici on recupere directement le champ du form ds l'id car ce n est pas un f.text_field 
  @reservations.dateinvitation=params[:dateinvitation] 
  @reservations.adresse=params[:adresse] 
  @reservations.vraiadresse=params[:vraiadresse]  
  @reservations.emailpartenaire=params[:emailpartenaire]  
  @reservations.author_id =current_user.id

  @reservations.invitation_id =params[:idinvitation]
  @reservations.email_membre =current_user.username
  @reservations.pseudo =current_user.email
  @reservations.author_nom =current_user.nom
  @reservations.author_prenom =current_user.prenom
  @reservations.sexe =current_user.sexe
  @reservations.code=code1
  @reservations.envoiemail = "true"
  @reservations.genre= @multi.genre
  @reservations.datelimite=@multi.datelimite
  

    
  @reservations.save   #on sauvegarde

   Notifier.send_resa_preferentiel_email(@reservations,@multi).deliver
  
    
  
  @paiment=Paiment.new
  @paiment.nom=charge.card.name
  @paiment.adresse=charge.card.address_line1
  @paiment.postal=charge.card.address_zip
  @paiment.ville=charge.card.address_city
  @paiment.nombre=params[:nombreinvitations]  
  @paiment.titre=params[:titre]
  @paiment.date1=params[:dateinvitation]
  @paiment.prix_ttc=@amount
  @paiment.prix_unitaire=@amount.to_i / @paiment.nombre.to_i
  @paiment.charge_id2=charge.id
  @paiment.author_id=current_user.id
  @paiment.save


   #Notifier.send_facture_email(@author,@paiment).deliver


   redirect_to charges_path


 


  end




end





def reservation_params
    params.require(:reservation).permit(:nombreinvitations)
  end


end
