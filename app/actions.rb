# Homepage (Root path)
get '/' do
  erb :index
end

# Use the provides condition to check the Accept header for JSON
get '/contacts', provides: :json do
  status 200
  json Contact.all
end

post '/contacts', provides: :json do
  contact_params = JSON.parse(request.env["rack.input"].read)
  contact = Contact.new(contact_params)
  # contact.attributes = contact_params.deep_symbolize_keys
  if contact.save
    status 201
    json contact
  else
    status 500
    json({success: false, message: contact.errors.full_messages.join(',')})
  end
end

get '/contacts/:id', provides: :json do
  contact = Contact.find_by_id(params[:id])
  unless contact
    status 404
    json({success: false, message: 'Invalid contact id'})
    return
  end
  status 200
  json contact
end

put '/contacts/:id', provides: :json do
  contact = Contact.find_by_id(params[:id])
  unless contact
    status 404
    json({success: false, message: 'Invalid contact id'})
    return
  end
  contact_params = JSON.parse(request.env["rack.input"].read)
  contact_params.deep_symbolize_keys
  contact_params.delete(:id)
  contact_params.keep_if do |key, value|
    Contact.attribute_names.include?(key)
  end
  contact.assign_attributes(contact_params)
  if contact.save
    status 202
    json contact
  else
    status 500
    json({success: false, message: contact.errors.full_messages.join(',')})
  end
end

delete '/contacts/:id' do
  contact = Contact.find_by_id(params[:id])
  unless contact
    status 404
    json({success: false, message: 'Invalid contact id'})
    return
  end
  if contact.destroy
    status 204
  else
    status 500
    json({success: false, message: contact.errors.full_messages.join(',')})
  end
end
