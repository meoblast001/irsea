require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe "/admin/quotes" do
  before(:each) do
    @response = request("/admin/quotes")
  end
end