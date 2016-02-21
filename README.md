# Description
UrSay.Click was created as a way for small businesses to conduct direct surveys to subscribers using SMS.

It was an entry to the CrowSourceHire [API Developer Contest](http://app.crowdsourcehire.com/challenge/muru-D/index) sponsored by Telstra, BuiltWith, SOFTLAYER, Xero & Dropbox for Business. Was awarded Runner up.

[Example site](https://ursay.herokuapp.com/)

## Technologies
- [Ruby on Rails 4](http://rubyonrails.org/) - used for the backend
- [Ruby 2](https://www.ruby-lang.org/) - used for Ruby on Rails 4
- [Prelang](http://prelang.com/) - used to generate the base Ruby on Rails app
- [Twitter Bootstrap 3](https://jquery.com/) - for the HTML templates
- [jQuery](https://jquery.com/) - for some effects
- [Font Awesome](http://fortawesome.github.io/Font-Awesome/icons/) - for the majority of icons
- [Telstra SMS API](https://dev.telstra.com/content/sms-api-0) - for sending SMS's to signed up users

## HTML Templates
- [SB Admin 2 Bootstrap Template](http://startbootstrap.com/template-overviews/sb-admin-2/) - login dashboard for company users
- [Flatty Bootstrap Template](http://www.bootstrapzero.com/bootstrap-template/flatty) - landing page template

## Resources
- [MockUPhone](http://mockuphone.com/) - for screenshot of text app on phone
- [Hipster Logo Generator](http://www.hipsterlogogenerator.com/) - for the logo
- [Icon Finder](http://iconfinder.com/) - for some icons

# Screenshots
## Dashboard
![Dashboard](https://s3-ap-southeast-2.amazonaws.com/bbody-images/github/ur-say/new_poll.png)

## Frontpage
![Front page](https://s3-ap-southeast-2.amazonaws.com/bbody-images/github/ur-say/front_page.png)

# How to run
1. Clone the repository `git clone https://github.com/bbody/ur_say.git`
2. Go into the directory `cd ur_say`
2. Run Postgres
2. Migrate the database `rake db:migrate`
3. Seed the database `rake db:seed`
4. Add the Telstra SMS API to *ur_say/config/secrets.yml*
5. Run `rails s`
