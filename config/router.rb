# irsea - router.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  # RESTful routes
  resources :quotes do |quotes|
    quotes.resources :comments
    quotes.resources :tags
  end
  resources :users
  
  # Adds the required routes for merb-auth using the password slice
  slice(:merb_auth_slice_password, :name_prefix => nil, :path_prefix => "")
  
  # Application routes
  match('/quotes/:id', :method => :post).to(:controller => "quotes",
                                                 :action     => "update")
                                                 
  match('/network/:name').to(:controller => "browse", :action => "network")
  match('/network/:name/:channel').to(:controller => "browse",
                                      :action     => "channel")
                                      
  match('/random').to(:controller => "quotes", :action => "random")

  # This is the default route for /:controller/:action/:id
  # This is fine for most cases.  If you're heavily using resource-based
  # routes, you may want to comment/remove this line to prevent
  # clients from calling your create or destroy actions with a GET
  default_routes
  
  # Change this for your home page to be available at /
  match('/').to(:controller => 'quotes', :action => 'index')
end
