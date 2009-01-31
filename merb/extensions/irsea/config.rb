# irsea - irsea_config.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

module IRSea

  # IRSea configuration loader
  class Config
  
    # Returns the value for a configuration item
    def self.[](item)
      @@config[item]
    end
    
    # Loads the configuration from file
    def self.load(filename = "config/irsea.yml")
      config_file = File.join(Merb.root, filename)
      Merb.logger.debug("Loading irsea config from #{config_file}")
      @@config = YAML.load_file config_file
    end
  
  end

end
