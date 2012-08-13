=begin
package   :  	Cupid's Buzz
authors   :     Manu S Ajith | neo@codingarena.in
      	  :	Jijo Sunny   | jijo@rubykitchen.org
copyright :	Copyright (C) 2012. All rights reserved.
license   :     GNU General Public License version 2 or later; see LICENSE.txt
website   :     http://codingarena.in
repo      :     http://github.com/manusajith/cupid
=end


require 'cuba'         # we are using Cuba web framework
require 'rack'         # using rack web server
require 'open-uri' 
require 'uri'
require 'launchy'
require 'twitter'      #twitter gem for ruby
require 'ghee'         #git API gem for ruby

Cuba.use Rack::Static,
  root: "public",
  urls: ["/js", "/css", "/images"]  #javascript, css and images folder
  
Cuba.define do

  
  on get do
  on root do
    res.write File.read('index.html')   #home page
  end
end

    on post do
    	on "submit" do
    		on param("name") do |name|      #get the name as variable "name"

			

               gh = Ghee.basic_auth("username","password")     #substitute your github username and password or you could use API Tockens
               gh.user.follow "#{name}"                        #follow the user on github
  
               Twitter.configure do |config|
               config.consumer_key = 'Your consumer key'
               config.consumer_secret = 'Your consumer_secret'
               config.oauth_token = 'Your oauth_token'
               config.oauth_token_secret = 'Your oauth_token_secret'  #substitute the dummy values with actual values



            end
            Twitter.follow("#{name}")                           #follow the user on twitter
            Launchy.open("https://www.facebook.com/dialog/friends/?id=" + "#{name}" + "&app_id=123050457758183&redirect_uri=http%3A%2F%2Fwww.example.com%2Fresponse%2F")
                                                                #send friend request on facebook

         end
     	

    		on true do
    			res.write "you are not supposed to be here "
    		end

    	end
    end  
end
