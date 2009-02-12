# irsea - application.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

class Application < Merb::Controller
  # ensures certain variables are generated for each request, like the total
  # quote count, etc
  before :setup
  # sets the theme for all controllers to the current theme setting in irsea.yml
  theme IRSea::Config["theme"]
end
