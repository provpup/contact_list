require './spec_helper'

RSpec.describe 'Contact List API routes' do
  include RackTestMixin

  before :all do
    @sam = Contact.create(firstname: 'Sam', lastname: 'Hudson', email: 'sam.hudson@abcdef.com')
    Contact.create(firstname: 'Sonia', lastname: 'Harris', email: 'sonia.harris@abcdef.com')
    Contact.create(firstname: 'Emma', lastname: 'Paterson', email: 'emma.paterson@abcdef.com')
    Contact.create(firstname: 'Sue', lastname: 'Jackson', email: 'sue.jackson@abcdef.com')
    Contact.create(firstname: 'Connor', lastname: 'Hughes', email: 'connor.hughes@abcdef.com')
    Contact.create(firstname: 'Theresa', lastname: 'North', email: 'theresa.north@abcdef.com')
    Contact.create(firstname: 'Stephen', lastname: 'Gibson', email: 'stephen.gibson@abcdef.com')
    Contact.create(firstname: 'Zoe', lastname: 'Harris', email: 'zoe.harris@abcdef.com')
    Contact.create(firstname: 'Steven', lastname: 'Short', email: 'steven.short@abcdef.com')
    @dorothy = Contact.create(firstname: 'Dorothy', lastname: 'Walsh', email: 'dorothy.walsh@abcdef.com')
  end
  
  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'should get all contacts as JSON' do
    get '/contacts'
    expect(last_response).to be_ok
    expect(last_response.content_type).to eql 'application/json'
    expect(last_response.body).to include_json(@sam.to_json)
    expect(last_response.body).to include_json(@dorothy.to_json)
  end
end
