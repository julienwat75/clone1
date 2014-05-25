class DetailresasController < ApplicationController

def show

 @reservation=Reservation.find(params[:id])


end

def index


	end


	def destroy

	@reservation=Reservation.find(params[:id])
	
    @reservation.destroy
    redirect_to reservations_path 

  end



end
