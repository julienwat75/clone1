desc "This task is called by the Heroku scheduler add-on"


task :update_feed => :environment do

   
   @invitation=Invitation.all
   @multidate=Multidate.all
   
   @multidate.each do |t| 

    
       
      

       #titre=t.titre 
       date1= DateTime.now
       vraidate=date1.to_datetime + (2.hours)
       
       
       envoiemailx=t.envoiemailx
       heuremail=t.heuremailpartenaire
       
        #newheure=  t.heuremailpartenaire.to_datetime + (5.year)  


       puts "il est #{vraidate}"
        puts "L'envoie du mail est a #{heuremail}"

           
        


       if (envoiemailx)  &&  (vraidate.to_datetime > heuremail.to_datetime) && t.gratuit

        #puts "le titre est #{titre}"
         puts "autorisation #{envoiemailx}"
       puts "on envoie le mail"
        #t.update_attribute(:heuremailpartenaire,newheure) 
        t.update_attribute(:envoiemailx, "false") 
         puts "on envoie le mail2"
         Notifier.send_partenaires_email(t).deliver
             

       end
  

       
       
      
    


  


end



end


task :reset_reservations => :environment do
  #User.send_reminders
   @author=Author.all

   @author.each do |t| 

     t.update_attribute(:limite, "false")
     t.update_attribute(:limite_payante, "false")
    
     

    end 

end


task :envoie_mail => :environment do


   puts "on envoie le mail génral"

    @author=Author.new
    @author=Author.all
    @invitations=Invitation.all

    @mailgenerals= Mailgeneral.last

    puts "Le mail est #{@mailgenerals.maildestinataire}"

    @destinataire= @mailgenerals.maildestinataire
    limite_blackliste = 2  # taux de point negatif pour etre blacklisté
    @ville="Paris"


    @grades = Hash.new
    @grades[0] = @mailgenerals.grade1
    @grades[1] = @mailgenerals.grade2
    @grades[2] = @mailgenerals.grade3







          if @mailgenerals.declenchement && @mailgenerals.type_mail == "evenement"    # ------  Mail html ---------

                     if @mailgenerals.envoigeneral 
                    @author.each do |author|

                    
                            if (author.point_negatif < limite_blackliste) && (author.ville==@ville) && (author.alerte)
                            Notifier.send_mail_general(@mailgenerals,author,@invitations,@destinataire).deliver
                            end
                

                                   end
                           else
                              
                              author=Author.find_by_username(@destinataire) 
                              if (author.point_negatif < limite_blackliste) && (author.ville==@ville) && (author.alerte)
                              Notifier.send_mail_general(@mailgenerals,author,@invitations,@destinataire).deliver
                              end

                             
        

                           end   

                    

         

          end



           if @mailgenerals.declenchement && @mailgenerals.type_mail == "derniereminute"   # ------  Mail html ---------

                  if @mailgenerals.envoigeneral 
                    @author.each do |author|

                     if (author.point_negatif < limite_blackliste) && (author.ville==@ville) && (author.alerte)
                    Notifier.send_mail_annonce_solo(@mailgenerals,author,@invitations,@destinataire,@grades).deliver
                     end
        

                                   end
                           else
                              
                              author=Author.find_by_username(@destinataire) 

                              
                             
                              if (author.point_negatif < limite_blackliste) && (author.ville==@ville) && (author.alerte)

                              Notifier.send_mail_annonce_solo(@mailgenerals,author,@invitations,@destinataire,@grades).deliver

                              end
        
        

                           end   

                    

         

          end

           if @mailgenerals.declenchement && @mailgenerals.type_mail == "pubpartenaire"  #--------- Mail uniquement en écriture -----

                  if @mailgenerals.envoigeneral 
                    @author.each do |author|

                      
                     Notifier.send_mail_simple(@mailgenerals,author,@invitations,@destinataire).deliver
                    

                                   end
                           else
                              
                             
                              author=@destinataire
                               
                               Notifier.send_mail_unique(@mailgenerals,author,@invitations,@destinataire).deliver
                               

        

                           end   


                    

         

          end


           if @mailgenerals.declenchement && @mailgenerals.type_mail == "message"  #--------- Mail uniquement en écriture -----

                  if @mailgenerals.envoigeneral 
                    @author.each do |author|
                      
                      if (author.point_negatif < limite_blackliste) && (author.ville==@ville) && (author.alerte)
                     Notifier.send_mail_simple(@mailgenerals,author,@invitations,@destinataire).deliver
                      end

                                   end
                           else
                              
                              author=Author.find_by_username(@destinataire) 
                              
                             
                                if (author.point_negatif < limite_blackliste) && (author.ville==@ville) && (author.alerte)
                               Notifier.send_mail_simple(@mailgenerals,author,@invitations,@destinataire).deliver
                                end

        

                           end   


                    

         

          end




   @mailgenerals.update_attribute(:declenchement, "false")
   


end



task :mail_partenaires => :environment do
  #User.send_reminders

  
   
   @invitation=Invitation.all
   
   @invitation.each do |t| 

    
       



       @date= DateTime.now
       
       
       @envoiemail=t.heuremailpartenaire
        #newheure=  t.heuremailpartenaire.to_datetime + (5.year)             
        


       #if @date.to_datetime > @envoiemail.to_datetime

       
        puts "on envoie le mail"
        #t.update_attribute(:heuremailpartenaire,newheure) 
        t.update_attribute(:envoiemail, "false") 
         puts "on envoie le mail2"
         #Notifier.send_partenaires_email(t).deliver
             

       #end
  

       puts "il est #{@date}"
        puts "L'envoie du mail est a #{@envoiemail}"


       
       
      
    


  


end


end