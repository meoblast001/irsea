# irsea - global_helpers.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

module Merb
  module GlobalHelpers
  
    # Formats text with RedCloth and sanitizes HTML, this is primarily used for
    # formatting comments
    def format_text(text)
      text = RedCloth.new(text)
      text.filter_html = true
      text.to_html
    end
    
    # Before filter to initialize variables commonly used in the application
    def setup
      @quote_count = Quote.count
    end
    
    # Helper to generate the title variables
    def page_title(text)
      @html_title = "#{IRSea::Config["site_title"]} | #{text}"
      @page_title = text
    end
    
    # Builds the network URL for a quote
    def network_url(quote)
      network = quote.network
      "/network/#{network.name}"
    end
    
    # Builds the channel URL for a quote
    def channel_url(quote)
      channel = quote.channel
      network_name = channel.network.name
      channel_name = channel.name.gsub(/\#/, "+")
      "/network/#{network_name}/#{channel_name}"
    end
    
    # Determines whether the edit link for a quote should be shown
    def show_edit_link?(quote)
      # Make sure there user property isn't nil to prevent anonymous users
      # from editing anonymous quotes, that was a really stupid bug
      if (quote.user != nil) and (quote.user == session.user)
        true
      else
        false
      end
    end
    
  end
end
