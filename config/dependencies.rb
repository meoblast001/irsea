# irsea - dependencies.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

# Merb stack dependencies
merb_gems_version = "1.0.8.1"
dm_gems_version   = "0.9.10"

dependency "merb-action-args",         merb_gems_version
dependency "merb-assets",              merb_gems_version  
dependency "merb-cache",               merb_gems_version   
dependency "merb-helpers",             merb_gems_version 
dependency "merb-mailer",              merb_gems_version  
dependency "merb-slices",              merb_gems_version  
dependency "merb-auth-core",           merb_gems_version
dependency "merb-auth-more",           merb_gems_version
dependency "merb-auth-slice-password", merb_gems_version
dependency "merb-param-protection",    merb_gems_version
dependency "merb-exceptions",          merb_gems_version
dependency "merb-haml",                merb_gems_version

dependency "dm-core",        dm_gems_version         
dependency "dm-aggregates",  dm_gems_version   
dependency "dm-migrations",  dm_gems_version   
dependency "dm-timestamps",  dm_gems_version   
dependency "dm-types",       dm_gems_version        
dependency "dm-validations", dm_gems_version

# Unversioned dependencies

require "redcloth"
require "sanitize"
require "merb-theme"
