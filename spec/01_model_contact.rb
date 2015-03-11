require './spec_helper'

RSpec.describe Contact do

  before :each do
    @contact = FactoryGirl.build :contact
  end

  describe '#id' do
    it 'should be able to get user id' do
      expect { @contact.id }.to_not raise_error
    end
  end

  describe '#firstname' do
    it 'should be able to get contact\'s first name' do
      expect { @contact.firstname }.to_not raise_error
    end

    it 'is required' do
      @contact.firstname = nil
      expect(@contact).to_not be_valid
      expect(@contact.errors[:firstname]).to include "can't be blank"
    end
  end

  describe '#lastname' do
    it 'should be able to get contact\'s last name' do
      expect { @contact.lastname }.to_not raise_error
    end

    it 'is required' do
      @contact.lastname = nil
      expect(@contact).to_not be_valid
      expect(@contact.errors[:lastname]).to include "can't be blank"
    end
  end

  describe '#email' do
    it 'should be able to get contact\'s email' do
      expect { @contact.email }.to_not raise_error
    end

    it 'is required' do
      @contact.email = nil
      expect(@contact).to_not be_valid
      expect(@contact.errors[:email]).to include "can't be blank"
    end

    it 'must be unique' do
      contact2 = FactoryGirl.build :contact
      contact2.email = @contact.email
      contact2.save

      expect(@contact).to_not be_valid
      expect(@contact.errors[:email]).to include "has already been taken"
    end
  end
end
