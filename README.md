## Contact List - A CLI App

### Introduction

**Goal:** Build a ruby command line application to help users manage their contacts through a Request-Response interface. This means that you will be issuing commands like:

        ruby contact_list.rb show 1
        
This would breakdown according to the following:

* `ruby` - Obviously, the ruby parser, same as you would use to run any Ruby script.
* `contact_list.rb` - The name of your script.
* `show` - The command you are going to issue to the Contact list app. (Full list of commands below)
* `1` - The parameter being passed to that command. (Tip: Not all commands will take parameters. Some will take multiple.)

**Repository:** Create a repository for this project (instead of working within the gist).

**Reminders & Tips:**
* Commit and push your progress on a regular basis
* Seed some fake data in so you donâ€™t have to create contacts each time you restart the app

### Setup

The project will be written in an Object Oriented way. Each contact will be represented by am instance of the `Contact` object. Similarly, the main application (responsible for user input and output) will be managed via an instance of `Application`.

Use the code provided. However, **instead of cloning this gist, simply copy/paste the code from it into your own brand new git repository** (create a folder and `git init` inside it), keeping the file names consistent of course.
    
### Bundler

This project uses Bundler, a very popular ruby library (gem) that helps us manage gem dependencies at the project level. The `Gemfile` is actually a _ruby_ file which lists which gems this projects needs to use. Bundler then manages the versions etc for us based on this file. Simple run `bundle install` to install the necessary gems for a given project.

Bundler is already installed on your vagrant machine, but running `gem install bundler` to install the latest version shouldn't cause any issues.

**More on Bundler:**

* <http://ruby.about.com/od/bundler/ss/What-Is-Bundler.htm>
* <http://yehudakatz.com/2010/09/30/bundler-as-simple-as-what-you-did-before/>

### Saving Data

In order for this app to work, you will need to save your data in a CSV (Comma-Separated Value) file. This is a very standard file format that is ideal for a Contact List app. To learn more about CSV files and the Ruby library for dealing with them, please read the following link:

<http://www.sitepoint.com/guide-ruby-csv-library-part/>

Here is another resource: [CSV file](http://ruby-doc.org/stdlib-2.0.0/libdoc/csv/rdoc/CSV.html)

Make a new file (`touch contacts.csv`) that will hold all of your data. When the app starts, it will look for this file. If the file is there, it should load all the contacts from it. In order to do this in an OOP way, you should introduce a ContactDatabase class that is responsible for reading and writing this file. 

**Optional:** "Seed" the csv file with some sample data so that you can start off working with existing contacts.

### Task Breakdown

#### Task 1: Main menu and user input

When the app receives the `help` command, it should display a menu with options. 

**The menu:**

    Here is a list of available commands:
	    new  - Create a new contact
	    list - List all contacts
	    show - Show a contact
   		find - Find a contact

#### Task 2: Implement contact creation (`new` command)

If the user issues the `new` command, the command line app should further prompt the user for information about the contact they wish to create. Eg: take a full name and email (separately). These should be added to an (initially empty) array of contacts. The full name and the email should be input as separate strings as they will need to be output as such.

Once a user has entered the data, the app should store the contact into the CSV file and return the ID of the new contact. 

**Note:** This does not mean that you need to store an ID in the file. How can you represent each row in the CSV as an ID?

#### Task 3: Implement Contact index (`list` command)

When the user enters the `list` command, the app should display a list of all contacts within the app, printed one on each line. Each line should be formatted as:

   #: \<first name> \<last initial> (\<email>)

The number (#) should start with 1 and represents an index or unique ID for each contact. Once the contacts are printed out to the screen, the app should exit.

#### Task 4: Contact details (`show` command)

When on the user sends in the `show` command along with an id (index) of the contact, the app should display their details. If a contact with that index/id is found, display their details, with each field being printed on an individual line. If the contact cannot be found, display a custom "not found" message.

#### Task 5: Implement Contact search (`find` command)

After issuing the `find` command, along with a search term, the app will search through the names of the contacts and print the contact details of any contacts which have the search term contained within their name or email. (ie. the search term is a substring of the contactâ€™s email or name)

Example use:

   ruby contact_list.rb find ted

#### Task 6: Prevent duplicate entries

If a user tries to input the exact contact with a the same email address twice, the app should output an error saying that the contact already exists and cannot be created. If you are asking for name first and then email, for a better user experience, it may make more sense to ask for their email first and then their name.

#### Task 7: Multiple phone numbers

Implement the ability to add contactâ€™s phone numbers. Contacts can have a limitless amount of phone numbers. Each phone number has a label and the number itself (eg: "Mobile" and "444-555-3123"). **Challenge:** How would you represent this label/data value in one CSV cell and display it properly?

### BONUS TASKS

#### Bonus: Make it executable!

You can make your contact_list.rb file run just like a command-line app from Linux/Unix. This involves the use of two modifications. Here are some key terms that you should Google to accomplish this:

* Shebang (No, not the Ricky Martin song!)
* Making shell scripts executable

When this is done, you should be able to do the following from the command line:

		./contact_list find ted

And it will run and produce the correct output. 
