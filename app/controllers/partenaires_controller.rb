class PartenairesController < ApplicationController


	def index
      
      @partenaires=Partenaire.all

     
	end

	def new

	 @partenaires=Partenaire.new	


	end


	def show

	@partenaire = Partenaire.find(params[:id]) 	


	end




	def create


	@partenaires = Partenaire.new(profil_params)
    @partenaires.nom = params[:partenaire][:nom] 
    @partenaires.email = params[:partenaire][:email]
    @partenaires.adresse = params[:partenaire][:adresse] 
    @partenaires.ville = params[:partenaire][:ville] 
    @partenaires.telephone = params[:partenaire][:telephone] 
 
 

    @partenaires.save   #on sauvegarde
    redirect_to pageinvitations_path     # redirection vers l'index





	end


	def edit

      @partenaire = Partenaire.find(params[:id]) 	
    end


    def destroy

    @partenaire = Partenaire.find(params[:id]) 	

    @partenaire.destroy
    respond_to do |format|
      format.html { redirect_to partenaires_url }
      format.json { head :no_content }
    end
  end


  def update
    @partenaire = Partenaire.find(params[:id]) 	
   nom = params[:partenaire][:nom]
   email= params[:partenaire][:email]
 
    adresse= params[:partenaire][:adresse]
    telephone= params[:partenaire][:telephone]
 
 

    respond_to do |format|
      if @partenaire
         @partenaire.update_attribute(:nom, nom)
         @partenaire.update_attribute(:email, email)
         @partenaire.update_attribute(:adresse, adresse)
         @partenaire.update_attribute(:telephone, telephone)
  
 
 
        format.html { redirect_to partenaires_path, notice: 'Author was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @partenaire.errors, status: :unprocessable_entity }
      end
    end
  end



	def partenaire_params
    params.require(:partenaire).permit(:nom,:email,:adresse,:telephone)
  end


  def profil_params
    params.require(:partenaire).permit(:nom,:email,:adresse,:telephone)
  end






end
