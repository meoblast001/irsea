# irsea - safe_session.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

module IRSea

  # Safe session extension for merb applications.  Generates a unique session
  # salt for an application install automatically instead of requiring the user
  # to do so themselves.
  class SafeSession
    
    require "digest/sha1"
    attr_reader :salt
    
    # Attempts to load the session salt from the saltfile, if it does not exist
    # a new salt is generated 
    def initialize(filename = "config/salt")
      file_path = File.join(Merb.root, filename)
      if File.exists? file_path
        @salt = load_salt(file_path)
      else # saltfile doesn't exist, let's generate a salt
        @salt = generate_salt
        save_salt(file_path)
      end
    end
    
    private
    
    # Loads the salt from file
    def load_salt(filename)
      @salt = File.new(filename).read
    end
    
    # Saves a generated salt to file
    def save_salt(filename)
      File.new(filename, "w").write(@salt)
    end
    
    # Generates a new salt
    def generate_salt
      Digest.hexencode(Digest::SHA1.digest(
       "#{rand(2 ** 128) * ( Time.now.to_i * Process.pid)}"))
    end
    
  end
  
end
