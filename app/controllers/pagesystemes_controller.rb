class PagesystemesController < ApplicationController

 before_filter :no_webmaster, only: [:index, :edit, :update]

 def no_webmaster
  
  unless  current_user && current_user.id == 3
    redirect_to pageinvitations_path
    return false
  end

end


	def index

     @pagesysteme=Pagesysteme.find(1)
	end


	def edit


      @pagesysteme=Pagesysteme.find(1)


    end


    def update
      
     @pagesysteme=Pagesysteme.find(1)
 
     option = params[:pagesysteme][:ouverture_invitation]

     @pagesysteme.update_attribute(:ouverture_invitation, option )

     redirect_to pagesystemes_path 


     


    end

    def new

  @pagesysteme=Pagesysteme.new
  
   


  end

  def create



    @code_bon = params[:vrai_code]

    

    @code_bon = @code_bon.strip
    @code = params[:code]
    @code = @code.strip
    @id = params[:invitation_id]

    

    if @code == @code_bon

      


     session[:foo] = "true"
     redirect_to reservation_path(@id)

    else

      @invite= Invitation.find(@id)

    redirect_to "/pages/code_errone" 

    end



  end


end
