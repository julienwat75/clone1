class Notifier < ActionMailer::Base
  default from: '"BilletGratuit" <billetgratuitparis@gmail.com>'

#default :from => 'any_from_address@example.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(author)
    @authors = author
    mail( :to => @authors.username,
    :subject => 'Votre inscription !!!!' )
  end


  def send_facture_email(author,paiment)
    @authors = author
    @paiment = paiment
    mail( :to => @authors.username,
    :subject => 'Votre facture' )
  end



   def send_resa_email(reservation)
    @reservations = reservation
    mail( :to => @reservations.email_membre,
    :subject => 'Votre coupon !!!!' )
  end



  def send_resa_preferentiel_email(reservation,multi)
    @reservations = reservation
     @multi = multi
    mail( :to => @reservations.email_membre,
    :subject => 'Votre coupon !!!!' )
  end

 def send_partenaires_email(multi)
    
    @invitations =multi.invitation
    @multi=multi
    mail( :to => @invitations.emailpartenaire,
    :subject => 'Réservation BilletGratuit.com' )
  end


def send_mail_general(mailgeneral, authors, invitations, destinataire)
    # can't send without a message, and an array of contacts 

    @mailgeneral = mailgeneral
    @authorx = authors

     
    
    @invitations = invitations
    @destinataire= destinataire

    # with variables set, let's create the loop to do its magic 
     mail = mail(
                :to => @authorx.username,
                :subject => "Nouvelles invitations")

 


  
         
    
 end #blast 

 def send_mail_annonce_solo(mailgeneral, authors, invitations, destinataire, grades)
    # can't send without a message, and an array of contacts 

    @mailgeneral = mailgeneral
    @authorx = authors
    @grades= grades
     
    
    @invitations = invitations
    @destinataire= destinataire

    # with variables set, let's create the loop to do its magic 
     mail = mail(
                :to => @authorx.username,
                :subject => "Invitations de dernière minute!")

 


  
         
    
 end #blast 



 def send_mail_simple(mailgeneral, authors, invitations, destinataire)
    # can't send without a message, and an array of contacts 

    @mailgeneral = mailgeneral
    @authorx = authors

     
    
    @invitations = invitations
    @destinataire= destinataire

    # with variables set, let's create the loop to do its magic 
     mail = mail(
                :to => @authorx.username,
                :subject => @mailgeneral.titre)

 


  
         
    
 end #blast 


 def send_mail_unique(mailgeneral, authors, invitations, destinataire)
    # can't send without a message, and an array of contacts 

    @mailgeneral = mailgeneral
    @authorx = authors

     
    
    @invitations = invitations
    @destinataire= destinataire

    # with variables set, let's create the loop to do its magic 
     mail = mail(
                :to => @authorx,
                :subject => @mailgeneral.titre)

 


  
         
    
 end #blast 





end
