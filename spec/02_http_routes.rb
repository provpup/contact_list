require './spec_helper'

RSpec.describe 'Contact List API routes' do
  include RackTestMixin
  
  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end
end