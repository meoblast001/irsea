# irsea - browse.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

class Browse < Application

  # Browse quotes by network
  def network(name)
    @network = Network.first(:name => name)
    if not @network
      raise NotFound
    end
    @quotes = @network.quotes.all(:limit => 10, :order => [:posted.desc])
    page_title @network.name
    display @quotes
  end
  
  # Browse quotes by network and channel
  def channel(name, channel)
    @network = Network.first(:name => name)
    if not @network
      raise NotFound
    end
    @channel = @network.channels.first(:name => channel.gsub(/\+/, "#"))
    if not @channel
      raise NotFound
    end
    @quotes = @channel.quotes.all(:limit => 10, :order => [:posted.desc])
    page_title "#{@channel.name} (#{@network.name})"
    display @quotes
  end
  
end
