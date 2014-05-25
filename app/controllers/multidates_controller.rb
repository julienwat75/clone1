class MultidatesController < ApplicationController

	def create
  @multidate = Multidate.new
  @multidate.invitation_id = params[:invitation_id]
  @multidate.datex = params[:datex]
  @multidate.placex = params[:placex]
  @multidate.gratuit = params[:gratuit]
  @multidate.privee = params[:privee]
  @multidate.genre = params[:genre]
  @multidate.code = params[:code]
  @heureenvoi = params[:heureenvoi]
  x=100
  @prix = params[:price]
  @prix_normal = params[:prix_normal]
  @prix_normal2 = @prix_normal.to_f * x



  

  @multidate.price = @prix.to_f * x
  @multidate.prix_normal =  @prix_normal2


  

  varenvoi = params[:dateenvoi]


  heureenvoi=params[:heureenvoi]
  minuteenvoi=params[:minuteenvoi]
  seconde="00"
  var4=varenvoi + " " + heureenvoi + ":" + minuteenvoi + ":" + seconde 

  @multidate.heuremailpartenaire= DateTime.parse(var4)
 





  var = params[:datex]
  heure=params[:heure1]
  minute=params[:minute1]
  seconde="00"
  var3=var + " " + heure + ":" + minute + ":" + seconde 

  varlimite = params[:datelimite]
  heurelimite=params[:heure2]
  minutelimite=params[:minute2]
  seconde="00"
  varlimite=varlimite + " " + heurelimite + ":" + minutelimite + ":" + seconde 


  @invitation=Invitation.find_by_id(params[:invitation_id])


 
  
   @multidate.datex = DateTime.parse(var3)

   @multidate.datelimite = DateTime.parse(varlimite)


    #heuremailpartenaire= @multidate.datex

    



   @multidate.update_attribute(:envoiemailx, true)

   @invitation.update_attribute(:validation, true)
 


  @multidate.save

  redirect_to invitation_path(@multidate.invitation)
end

def edit



  @multidate=Multidate.find(params[:id])



  end


  def update

    

   
  @multidate = Multidate.find params[:id]
  

  place = params[:placex]

  varenvoi = params[:dateenvoi]





  heureenvoi=params[:heureenvoi]
  minuteenvoi=params[:minuteenvoi]
  seconde="00"
  var4=varenvoi + " " + heureenvoi + ":" + minuteenvoi + ":" + seconde 


    

    
    @multidate.update_attribute(:heuremailpartenaire, DateTime.parse(var4))
     @multidate.update_attribute(:placex, place )
      @multidate.update_attribute(:envoiemailx, true )





    


    
 
    redirect_to pageinvitations_path 




  end


def multidate_params
  params.require(:multidate).permit(:datex, :placex, :gratuit)
end

end
