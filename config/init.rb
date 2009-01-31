# irsea - init.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll
 
require 'config/dependencies.rb'
 
use_orm :datamapper
use_test :rspec
use_template_engine :haml
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  # Setup the session store, require the safe_session extension to generate a
  # unique salt for the application if one does not already exist
  c[:session_store] = 'cookie'
  require File.join(Merb.root, "merb/extensions/irsea/safe_session.rb")
  safe_session = IRSea::SafeSession.new
  c[:session_secret_key]  = safe_session.salt
  c[:session_id_key] = '_irsea_session_id'
end
 
Merb::BootLoader.before_app_loads do
  # Begin irsea extension load
  Dir["#{Merb.root}/merb/extensions/*.rb"].each do |extension|
    require extension
  end
  # Load the irsea configuration
  IRSea::Config.load
  # Initialize the application theme
  IRSea::Theme.init
end
 
Merb::BootLoader.after_app_loads do
  # This will get executed after your app's classes have been loaded.
end
