class AuthorsController < ApplicationController
  
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  #before_action :connect_authors, only: [:new]


  before_filter :no_sessions, only: [:show]

  before_filter :no_webmaster, only: [:index]



  before_filter :verify_authenticity_token, :only => [ :show]

def no_sessions
  @author = Author.find(params[:id])

  if  current_user == nil || (current_user && (current_user.id != @author.id) && (current_user.id!=3)) 
    redirect_to pageinvitations_path
    return false
  end

end

def no_webmaster
  
  unless  current_user && current_user.id == 3
    redirect_to pageinvitations_path
    return false
  end

end


def zero_authors_or_authenticated

  
  if current_user 
    redirect_to root_path
    return false
  end
end

def connect_authors

  
  if current_user 
    redirect_to root_path
    return false
  end
end

  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.order("id DESC").all

    
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
     @authors = Author.find(params[:id]) #reccupere l'id de l url
     @commentaires = Commentaire.new
     @commentaires.author_id = @authors.id

     @username=current_user

     
  end

  # GET /authors/new
  def new
    @author = Author.new
    @faux=@author.errors.any?
    render :layout => true


  end

  # GET /authors/1/edit
  def edit

    token=params[:token]

   @a=Author.find_by token:token

   if @a

     auto_login(@a)# login without credentials
     
   end 

   
  end

  # POST /authors
  # POST /authors.json
  


def create              # le submit va chercher la methode create
  @authors = Author.new(author_params)
  
  @authors.username = params[:author][:username]  # on reccupere le nom du form
  @authors.email = params[:author][:email] # on reccupere le body du form 
  @authors.password = params[:author][:password] # on reccupere le body du form 
  @authors.password_confirmation = params[:author][:password_confirmation] # on reccupere le b
  @authors.avatar = params[:author][:avatar] # on reccupere le body 
  @authors.nom = params[:author][:nom]
  @authors.prenom = params[:author][:prenom]
  @authors.sexe = params[:author][:sexe]
  @authors.newsletter = params[:author][:newsletter]
  @authors.partenaires = params[:author][:partenaires]
  @authors.date_naissance = params[:date_naissance]
  @authors.ville = params[:ville]
  @authors.point_positif = 0
  @authors.point_negatif = 0
  @authors.alerte = true
  
  
  
  
   
   

  if @authors.save   #on sauvegarde

    
     
   Notifier.send_signup_email(@authors).deliver


    if login(params[:author][:username],params[:author][:password])

       flash[:success] = "Welcome to billetgratuit.com!"
      

    else
      flash.now.alert = "Login failed."

      

      
    end


   

   redirect_to author_path(current_user.id)     # redirection vers l'index
   
   else

    @author=@authors
    
    render :new


    end

end



  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update

    @author = Author.find(params[:id])


    if current_user.id == 3

   point_positif = params[:point_positif]
   point_negatif= params[:point_negatif]
   ville= params[:ville]




    
    @author.update_attribute(:point_positif, point_positif) 


    @author.update_attribute(:point_negatif, point_negatif) 

    @author.update_attribute(:ville, ville) 


  else


  alerte = params[:author][:alerte]



  @author.update_attribute(:alerte, alerte) 







   end 


   
    redirect_to @author 


    
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:username, :email, :password, :password_confirmation, :avatar, :nom , :prenom, :sexe, :nom_resa, :ville, :date_naissance)
    end
end
