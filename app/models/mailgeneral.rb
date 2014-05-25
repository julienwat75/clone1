class Mailgeneral < ActiveRecord::Base


	attr_accessible :titre, :body, :envoigeneral, :maildestinataire, :type_mail

end
