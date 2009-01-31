# irsea - theme.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

module IRSea

  # irsea theme helper
  class Theme
    require "fileutils"
    def self.init
      theme_dir = File.join(Merb.root, "themes", IRSea::Config["theme"])
      stylesheet_dir = File.join(theme_dir, "files", "stylesheets")
      image_dir = File.join(theme_dir, "files", "images")
      javascript_dir = File.join(theme_dir, "files", "javascripts")
      merb_image_dir = File.join(Merb.dir_for(:image), "theme")
      merb_javascript_dir = File.join(Merb.dir_for(:javascript), "theme")
      merb_stylesheet_dir = File.join(Merb.dir_for(:stylesheet), "theme")
      
      # Setup image and javascript directories
      File.delete(merb_image_dir) if File.symlink? merb_image_dir
      
      File.delete(merb_javascript_dir) if File.symlink? merb_javascript_dir
      
      FileUtils.rm_rf(merb_stylesheet_dir) if File.exists? merb_stylesheet_dir
        
      File.symlink(image_dir, merb_image_dir)
      
      File.symlink(javascript_dir, merb_javascript_dir)
      # Setup stylesheets

      Merb::Plugins.config[:sass][:template_location] =
        File.join(stylesheet_dir, "sass")
      Merb::Plugins.config[:sass][:css_location] =
        "./public/stylesheets/theme"
    end
  
  end

end
