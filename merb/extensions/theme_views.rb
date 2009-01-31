# irsea - theme_views.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

module Merb::Template
  class << self
    # Overrides load_template_io to search for templates in the theme directory
    # if one is not present in the app/ tree
    def load_template_io(path)
      # Check to see if we can already find the template in the app/ tree
      io = super
      
      # If not, try and load the template from the current theme
      if io.nil?
      
        # Make sure the path looks right, we don't want to try and work on a
        # path we can't handle, bad shit would probably happen
        if path =~ /^.*\/app\/views\/.*$/
          rel_path = path[/^.*\/app\/views\/(.*)$/, 1] # Only get what we need
          theme_root = File.join(Merb.root, "themes", IRSea::Config["theme"],
            "templates")
          template_path = File.join(theme_root, rel_path)
          template_list =
            Dir["#{template_path}.{#{template_extensions.join(',')}}"]
          template_file = template_list.first
          io = File.open(template_file, "r") if template_file
        end
        
      end
      
      io # Return all or nothing
    end
  end
end
