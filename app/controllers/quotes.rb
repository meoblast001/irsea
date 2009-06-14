# irsea - quotes.rb
# Author    :: Stefan Nuxoll
# License   :: BSD License
# Copyright :: Copyright (C) 2009 Stefan Nuxoll

class Quotes < Application
  provides :xml, :yaml, :json

  # Homepage / recent quote list
  def index
    @quotes = Quote.recent
    page_title "recent quotes"
    display @quotes
  end
  
  # Random quote list
  def random
    @quotes = Quote.random
    page_title "random quotes"
    display @quotes
  end
  
  # Quote view page
  def show(id)
    @quote = Quote.get(id)
    raise NotFound unless @quote
    # Don't use the page_title helper since the quote name is likely shown in
    # the quote partial anyways, so we'll just set @page_title to the quote
    # number.
    @html_title = "ircwall | #{@quote.title}"
    @page_title = "quote \##{@quote.id}"
    display @quote
  end

  # Quote submission page
  def new
    only_provides :html
    @quote = Quote.new # FIXME why the hell is this here? is it even needed?
    @networks = Network.all(:order => [:name.asc])
    page_title "submit quote"
    display @quote
  end

  # Quote creation action
  def create(quote)
      if quote ["network"] == "other"
        if IRSea::Config["user_networks"] == true
          network = Network.new;
          network.name = quote["network_name"];
          network.user_made = true;
        else
          raise NotAcceptable
        end
      else
        network = quote["network"]
      end
      quote["network"] = network
      # Check to see if a channel exists in the database, if not, create it
      channel = network.channels.first(:name => quote["channel"].downcase)
      if not channel
        channel         = Channel.new
        channel.network = network
        channel.name    = quote["channel"].downcase
        channel.save
      end
      quote["channel"] = channel
      quote["posted"]  = Time.now
      quote["user"] = session.user if session.authenticated?
      @quote           = Quote.new(quote)
      if @quote.save
        redirect resource(@quote), :message => {:notice => "Quote posted"}
      else
        # We have to generate the @networks list here since we are calling
        # render instead of doing a redirect
        @networks = Network.all(:order => [:name.asc])
        render :new
      end
  end
  
  # Quote edit page
  def edit(id)
    @quote = Quote.get(id)
    raise NotFound unless @quote
    # Make sure the quote isn't anonymous or we'll have ac's editing each others
    # quotes and all hell would break loose
    if (@quote.user != nil) and (@quote.user == session.user)
      @networks = Network.all(:order => [:name.asc])
      render
    else
      redirect resource(@quote),
        :message => {:error => "You can't edit this quote"}
    end
  end
  
  # Quote update action
  def update(id, quote)
    @quote = Quote.get(id)
    if (@quote.user != nil) and (@quote.user == session.user)
      quote["network"] = Network.get(quote["network"])
      network = quote["network"]
      channel = network.channels.first(:name => quote["channel"].downcase)
      if not channel
        channel = Channel.new
        channel.network = network
        channel.name = quote["channel"].downcase
        channel.save
      end
      quote["channel"] = channel
      @quote.update_attributes(quote)
      @quote.posted = Time.now
      if @quote.save
        redirect resource(@quote), :message => {:notice => "Quote updated"}
      else
        redirect resource(@quote), :message => {:error  => "Update failed!"}
      end
    else
      redirect resource(@quote),
        :message =>
          {:error => "You can't update quotes you didn't post, go away!" }
    end
    
  end
end
