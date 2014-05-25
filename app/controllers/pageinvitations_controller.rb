class PageinvitationsController < ApplicationController



  before_filter :zero_authors_or_authenticated 


  def zero_authors_or_authenticated
  unless Invitation.count == 0 || current_user
    redirect_to login_path
    return false
  end
end




def index

  @pagesysteme=Pagesysteme.find(1)

  limite_blackliste = 2


  unless  current_user && current_user.id == 3
   
   if @pagesysteme.ouverture_invitation == false || current_user.point_negatif >= limite_blackliste 
   redirect_to "/pages/nondisponible" 
   end

  end


a=0
@user=current_user
 #a=params[:id]
@page_suivante=a.to_i+1


#--------------------------------------- mise a jour validation --------------------------------------

@invitation1=Invitation.all


  @invitation1.each do |t| 

         if t.multidates.length > 0 && Invitation.late(t.multidates.order(:datex).last.datex) 



         

          else

          t.update_attribute(:validation, false)


         end 


 end

 #------------------------------------------------------------------------------------------------------       


  

@invitations2=Invitation.find(:all,
                     :conditions => {:validation => true},
                      :order      =>  "dateinvitation",
                      :limit      =>  20,
                       :offset      =>  a.to_i*20)     # numero de page qu on souhaite afficher


@comptage=Invitation.find(:all,
                     :conditions => {:validation => true})     # numero de page qu on souhaite afficher







calcul=@comptage.count.to_f/20
@nombre_pages=calcul.ceil



 

end





def show

   @pagesysteme=Pagesysteme.find(1)

  limite_blackliste = 2


  unless  current_user && current_user.id == 3
   
   if @pagesysteme.ouverture_invitation == false || current_user.point_negatif >= limite_blackliste 
   redirect_to "/pages/nondisponible" 
   end

  end

#a=1
@user=current_user
 a=params[:id]
@page_suivante=a.to_i+1


#--------------------------------------- mise a jour validation --------------------------------------

@invitation1=Invitation.all


  @invitation1.each do |t| 

         if t.multidates.length > 0 && Invitation.late(t.multidates.order(:datex).last.datex) 



         

          else

          t.update_attribute(:validation, false)


         end 


 end

 #------------------------------------------------------------------------------------------------------       


  

@invitations2=Invitation.find(:all,
                     :conditions => {:validation => true,:validation => true},
                      :order      =>  "dateinvitation",
                      :limit      =>  20,
                       :offset      =>  a.to_i*20)     # numero de page qu on souhaite afficher

@comptage=Invitation.find(:all,
                     :conditions => {:validation => true})     # numero de page qu on souhaite afficher




calcul=@comptage.count.to_f/20
@nombre_pages=calcul.ceil

 

  end






end
