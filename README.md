# Contact List App (v4) - The API edition

That's right. It's back. Bigger, madder, and with more ammo. You're going to build another version of your contact list app, but this time it's going to have the following characteristics:

* It will be a web app
* You will use Sinatra (Use the skeleton code [here](https://github.com/lighthouse-labs/sinatra-skeleton) )
* It will be an API
* It will use jQuery to talk to the server

## API?

Yes, your Contact List App is going to be a backend service that will serve up JSON to AJAX requests. Contacts, Search results, posting new contacts, etc. will all have their responses be served up as JSON objects, and then displayed in your web app. This way, theoretically any service could interact with your contact list. 

Don't worry about OAuth or tokens or anything like that. 

**Your API should not be serving up ANYTHING but JSON. No HTML, CSS, or JavaScript.**

## Endpoints

Your routing in your Sinatra app will be just as important as before, perhaps more so, as it is the 'front-end' of your API. Logical routes should be constructed for the purposes of sending and receiving data with the API. 

All of the functionality that you had before (Adding new contacts, searching contacts, listing contacts, viewing a contact, deleting contacts) should be available through the web interface. Each one should have a separate endpoint (route) to accomplish the task. 

Something you may have noticed in some APIs (GitHub, Instagram) is that they will namespace their routes/endpoints by having `/api/v1/<action>` or `/api/v2/<action>` as a way to designate different functionality on the same endpoint. Your app probably shouldn't grow to this point, but it is valuable to know that this is a common technique used when building service APIs.

## CSS!

Take some time to present your contacts and your forms in a visually-pleasing manner. (But not too much!) Frameworks like Bootstrap and Foundation can help you with this. 

## jQuery

The jQuery AJAX methods are going to be very important to you.

* `$.get()`
* `$.post()`
* `$.getJSON()`
* `$.ajax()`

Remember that if you are using `$.get()`, `$.post()`, or `$.ajax()` you have to specify the data type as JSON, for jQuery to understand the JSON object that it receives from the server. 

## BONUS (optional)

Integrate a third-party API like Instagram or Twitter to supplement the contact details for your contacts. Perhaps add a 'Twitter handle' field as a contact field, and if supplied, it fetches the user's twitter avatar. You would need to set up an app on the third-party service (Ex. [Twitter Apps](https://apps.twitter.com) ) and get an API token to be able to communicate with the third-party API. But it will also give you some exposure to their API endpoint naming and documentation, which can help you craft yours.

