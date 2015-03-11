# Homepage (Root path)
get '/' do
  erb :index
end

# Use the provides condition to check the Accept header for JSON
get '/contacts', provides: :json do
  content_type :json
  status 200
  Contact.all.to_json
end

post '/contacts', provides: :json do
  content_type :json
  contact = Contact.new(firstname: params[:firstname], lastname: params[:lastname], email: params[:email])
  if contact.save
    status 201
    contact.to_json
  else
    status 500
    return {success: false, message: contact.errors.full_messages.join(',')}.to_json
  end
end

get '/contacts/:id', provides: :json do
  content_type :json
  contact = Contact.find(params[:id])
  unless contact
    status 404
    return {success: false, message: 'Invalid contact id'}.to_json
  end
  status 200
  contact.to_json
end

put '/contacts/:id', provides: :json do
  content_type :json
  contact = Contact.find(params[:id])
  unless contact
    status 404
    return {success: false, message: 'Invalid contact id'}.to_json
  end
  contact.update_attributes(params[:contact])
  if contact.save
    status 202
    contact.to_json
  else
    status 500
    return {success: false, message: contact.errors.full_messages.join(',')}.to_json
  end
end

delete '/contacts/:id' do
  content_type :json
  contact = Contact.find(params[:id])
  unless contact
    status 404
    return {success: false, message: 'Invalid contact id'}.to_json
  end
  if contact.destroy
    status 204
  else
    status 500
    return {success: false, message: contact.errors.full_messages.join(',')}.to_json
  end
end

#    contact_phone_numbers GET    /contacts/:contact_id/phone_numbers(.:format)          phone_numbers#index
#                          POST   /contacts/:contact_id/phone_numbers(.:format)          phone_numbers#create
# new_contact_phone_number GET    /contacts/:contact_id/phone_numbers/new(.:format)      phone_numbers#new
#edit_contact_phone_number GET    /contacts/:contact_id/phone_numbers/:id/edit(.:format) phone_numbers#edit
#     contact_phone_number GET    /contacts/:contact_id/phone_numbers/:id(.:format)      phone_numbers#show
#                          PATCH  /contacts/:contact_id/phone_numbers/:id(.:format)      phone_numbers#update
#                          PUT    /contacts/:contact_id/phone_numbers/:id(.:format)      phone_numbers#update
#                          DELETE /contacts/:contact_id/phone_numbers/:id(.:format)      phone_numbers#destroy

