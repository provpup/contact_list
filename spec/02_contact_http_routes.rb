require './spec_helper'

RSpec.describe 'Contact List API routes' do
  include RackTestMixin

  before :all do
    10.times do
      FactoryGirl.create :contact
    end
    @sam = Contact.first
    @dorothy = Contact.last
  end
  
  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'should get all contacts as JSON' do
    get '/contacts'
    expect(last_response.ok?).to be_truthy
    expect(last_response.content_type).to eql 'application/json'
    expect(last_response.body).to include_json(@sam.to_json)
    expect(last_response.body).to include_json(@dorothy.to_json)
  end

  it 'should be able to create a new contact' do
    post '/contacts', { firstname: 'Steve', lastname: 'Hammond', email: 'steve@gmail.com' }.to_json
    expect(last_response.created?).to be_truthy
    steve = Contact.last
    expect(steve.firstname).to eq 'Steve'
    expect(steve.lastname).to eq 'Hammond'
    expect(steve.email).to eq 'steve@gmail.com'
  end

  it 'should be able to retrieve a single contact' do
    get "/contacts/#{@dorothy.id}"
    expect(last_response.ok?).to be_truthy
    expect(last_response.content_type).to eql 'application/json'
    expect(last_response.body).to eql @dorothy.to_json
  end

  it 'should be able to handle retrieving an invalid contact id' do
    get '/contacts/1000000'
    expect(last_response.not_found?).to be_truthy
  end

  it 'should be able to update a single contact' do
    put "/contacts/#{@dorothy.id}", { firstname: 'Diana' }.to_json
    expect(last_response.successful?).to be_truthy
    expect(last_response.content_type).to eql 'application/json'
    @dorothy.reload
    expect(@dorothy.firstname).to eql 'Diana'
  end

  it 'should be able to handle updating an invalid contact id' do
    put '/contacts/1000000'
    expect(last_response.not_found?).to be_truthy
  end

  it 'should be able to delete a single contact' do
    contact_id = @dorothy.id
    delete "/contacts/#{contact_id}"
    expect(last_response.successful?).to be_truthy
    expect(Contact.find_by_id(contact_id)).to be_falsey
  end

  it 'should be able to handle deleting an invalid contact id' do
    delete '/contacts/1000000'
    expect(last_response.not_found?).to be_truthy
  end


end
