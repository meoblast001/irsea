# irsea - quotes_helper.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

module Merb
  module QuotesHelper
    def rss_url(quote)
      "#{IRSea::Config["site_url"]}#{resource(quote)}"
    end
  end
end # Merb
