#list-backbone App
How to use this application

        $ git git@github.com:vicmaster/list-backbone.git
        $ cd list-backbone
        $ bundle install
        $ rake db:setup
        $ rake db:seed
        $ git add .
        $ git commit -m "Initialize git repository in local"

###You can see the demo in action

http://backbone-list.herokuapp.com/


###The Next guide Will show you How this application was created

Important note: before to continue in my case i found a big problem with the assets that not recognize the javascripts files for this problem i rewrite the file application.js and remove require_tree for require_self and all the remain code works fine my code looks like:

        //= require jquery
        //= require jquery_ujs
        //= require_self
        //= require underscore
        //= require backbone
        //= require .//backbone_app
        //= require_tree ../templates/
        //= require_tree .//models
        //= require_tree .//collections
        //= require_tree .//views
        //= require_tree .//routers


So in case that you have problems to cotinue with the tutorial view in you console in google chrome and see if you dont have problems with javascript if you find problem you should resolve to continue.
Open your terminal console in my case using ubuntu ctrl + Alt + t

        $ rails new backbone-app
        $ cd backbone-app

After that, we created a controller called main controller using rails generate
        $ rails g controller main index --skip-javascripts

To initialize our app using git to controller versions

        $ git init
        $ git add .
        $ git commit -m “initialize our new application”

we edit our fil app/view/mains/index.html.erb with the next code:

        <div id = “container”></div>

and remove the file public/index.html.erb

after that we config the file config/routes.rb and change the code:

        get ‘main/index’
        to
        root to: ‘main#index’

now whe can observe our app running with the next code:

        $ bundle install #install our gems
        $ rails server or only rails s

Now we going to use the gem https://github.com/meleyal/backbone-on-rails

to use that we must stop our server in console using ctrl + c

So to use the gem we need to add the gem at the file Gemfile

        gem 'backbone-on-rails'

After add the gem we need run the bundle install from our console

        $ bundle install

Now lets go to create the structure of backbone using the console too

        $ rails g backbone:install

Later we can find the file and skeleton in the dir app/assets/javascript

now we can run our server

        $ rails s

After see in our browser in the url http://localhost:3000 we can see and alert dialog that is made in backbone and we can find in the file app/assets/javascripts/backbone_app.js.coffee or with the name of our application if we want to remove the alert is located in the initialize function only remove if you want.

Now we going to create a new scaffold table using backbone and the code is the next

        $ rails g backbone:scaffold entries

Now we going to see our files created in app/assets/javascript and we open and edit the next file app/assets/javascripts/routers/entries.js.coffee  And we add the next code:

        class BackboneApp.Routers.Entries extends Backbone.Router
          routes:
            '' : 'index'



          index: ->
            alert 'hello to home page'

and add the next code to the file the file app/assets/javascripts/backbone_app.js.coffee

        window.BackboneApp =
          Models: {}
          Collections: {}
          Views: {}
          Routers: {}
          init: ->
            new BackboneApp.Routers.Entries()
            Backbone.history.start()

        $(document).ready ->
          BackboneApp.init()


Later in lets go to edit the views in javascripts/views/entries/index.js.coffee adding the next code

        class BackboneApp.Views.EntriesIndex extends Backbone.View

          template: JST['entries/index']

          render: ->
            $(@el).html(@template())
            this


and in the routers/entries.js.coffee now we update de code to use the view
        class BackboneApp.Routers.Entries extends Backbone.Router
          routes:
            '' : 'index'
            'entries/:id': 'show'

          index: ->
            view = new BackboneApp.Views.EntriesIndex()
            $('#container').html(view.render().el)

          show:(id) ->
            alert "hello #{id}"


later in our templates/entries/index.jst.eco we add the code that we need to show in the view too like:



in the view the views in javascripts/views/entries/index.js.coffee we can pass attributes to use in the file something like this:

         render: ->
            $(@el).html(@template(stories: "some text to the variable"))
            this

and in the view app/assets/templates/entries/index.jst.eco we can use that varible like this:

        <h1>The Container</h1>
        <%= @stories %>


Now we going to add the url in the file app/asset/javascripts/collections/entries.js.coffee and we will use the url api/entries to avoid conflicts with another resources.the code looks like:

        class BackboneApp.Collections.Entries extends Backbone.Collection
          url: 'api/entries'
          model: BackboneApp.Models.Entry

After we going to create the model to refresh and do the table:

        $ rails g resource entry name winner:boolean --skip-javascripts

and migrate the database to create the table and the database

        $ rake db:migrate

later we work with the controller created before app/controller/entries_controller.rb and the code inside of him is the next to works with data in format json all the time:

        class EntriesController < ApplicationController
          respond_to :json

          def index
            respond_with Entry.all
          end

          def create
            respond_with Entry.create(params[:entry])
          end

          def show
            respond_with Entry.find(params[:id])
          end

          def update
            respond_with Entry.update(params[:id], params[:entry])
          end

          def destroy
            respond_with Entry.destroy(params[:id])
          end

        end

And now we need to change the file config/routes.rb and should looks like:
          scope "api" do
            resources :entries
          end

and got to create some data to list in the model entry for do that we go to the file db/seed.rb and write some data like:
        Entry.create!(name: "heriberto pere")
        Entry.create!(name: "Alma decinia")
        Entry.create!(name: "rauls armando perez")
        Entry.create!(name: "jose heriberto perez")
        Entry.create!(name: "claudia cecilia")
        Entry.create!(name: "ma concepcion magania")
        Entry.create!(name: "jsoe alberto carrasco")
        Entry.create!(name: "Elizabeth martinez")
        Entry.create!(name: "francisco cardenas san")
        Entry.create!(name: "Herbert andres parra")

and run the command to create the new data:

        $ rake db:seed

Now if we go to the url localhost:3000/api/entries.json we see the entries in format json

now we can test if the information is passing to the view writing in the console of google chrome the next codes:

        algo = new BackboneApp.Collections.Entries()
        algo.fetch
        algo.length

and we can see the count of records in our database.

Now that we see that the collections data works fine we continue with file app/assets/javascripts/routers/entries.js.coffee and add the initialize information to recover the data and initialize that information and we pass the collection to the view to use that:

         initialize: ->
            @collection = new BackboneApp.Collections.Entries()
            @collection.fetch()

          index: ->
            view = new BackboneApp.Views.EntriesIndex(collection: @collection)
            $('#container').html(view.render().el)

and we pass that collection to the file app/assets/javascripts/views/entries/index.js.coffee too.

        class BackboneApp.Views.EntriesIndex extends Backbone.View

          template: JST['entries/index']

          initialize: ->
            @collection.on('reset',@render, this)

          render: ->
            $(@el).html(@template(stories: @collection))
            this


The secon part creating and listing new entrys:

Now we going to add a new form to add new entries and the file where we put that code is in the template file app/assets/templates/index.jst.eco where the listing entries is:

        <h1>The Container</h1>
        <form id= "new_entry">
          <input type= "text" name= "name" id="new_entry_name">
          <input type = "submit" value= "add">
        </form>
        <ul>
        <% for entry in @stories.models: %>
          <li><%= entry.get('name') %></li>
        <% end %>
        <ul>

now  we need to configure the  events to recognize our form and add to the database that record, now we open the file in app/assets/javascripts/views/entries/entries_index.js.coffee and the code looks like the next:

        class BackboneApp.Views.EntriesIndex extends Backbone.View

          template: JST['entries/index']

          events:
            'submit #new_entry': 'createEntry'

          initialize: ->
            @collection.on('reset',@render, this)

          render: ->
            $(@el).html(@template(stories: @collection))
            this

          createEntry: (event)->
            event.preventDefault()
            @collection.create name: $('#new_entry_name').val()


and now we need to add the new record added for that the solution is  easy only in this file too add the next line in the initialize with add

        initialize: ->
          @collection.on('reset',@render, this)
          @collection.on('add',@render, this)

the only problem with that solution is that all the page is reloaded all the elements in that and now we go to add a best refactoring solution to only add at the dom the element added and not all the element ok.

for the refactoring solution we now create and individual entry to only refresh that and no the entire page.

we create a new file in app/assets/javascripts/views/entry.js.coffee and add the next code

      class BackboneApp.Views.Entry extends Backbone.View

        template: JST['entries/entry']

        render: ->
          $(@el).html(@template())
          this

and we created too the file template in app/assets/templates/entries/entry.jst.eco with the next code:
for this momento only write any code like:

        <%= @entry.get('name') %>

Now we going to edit again the file app/assets/templates/entries/index.jst.eco and we put the next code:

        <h1>The Container</h1>
        <form id= "new_entry">
          <input type= "text" name= "name" id="new_entry_name">
          <input type = "submit" value= "add">
        </form>
        <ul id = "entries"><ul>

later we need to edit again the file app/assets/javascripts/views/entries/index.js.coffee and the code with the modifications looks like:

        class BackboneApp.Views.EntriesIndex extends Backbone.View

          template: JST['entries/index']

          events:
            'submit #new_entry': 'createEntry'

          initialize: ->
            @collection.on('reset',@render, this)
            @collection.on('add',@appendEntry, this)

          render: ->
            $(@el).html(@template())
            @collection.each(@appendEntry)
            this

          appendEntry: (entry) ->
            view = new BackboneApp.Views.Entry(model: entry)
            $('#entries').append(view.render().el)

          createEntry: (event)->
            event.preventDefault()
            @collection.create name: $('#new_entry_name').val()
            $('#new_entry_name').val(‘’)

Now we going to validate our form that doesnt allow create record in blank and we need validate the model entry.rb

        class Entry < ActiveRecord::Base
          validates_presence_of :name
        end

and we need to edit the file app/assets/javascripts/views/entries/index.js.coffee again.

        class BackboneApp.Views.EntriesIndex extends Backbone.View

          template: JST['entries/index']

          events:
            'submit #new_entry': 'createEntry'

          initialize: ->
            @collection.on('reset',@render, this)
            @collection.on('add',@appendEntry, this)

          render: ->
            $(@el).html(@template())
            @collection.each(@appendEntry)
            this

          appendEntry: (entry) ->
            view = new BackboneApp.Views.Entry(model: entry)
            $('#entries').append(view.render().el)

          createEntry: (event) =>
            event.preventDefault()
            attributes = name: $('#new_entry_name').val()
            @collection.create attributes,
              wait: true
              success: -> $('#new_entry')[0].reset()
              error: @handleError

          handleError: (entry, response) ->
            if response.status == 422
              errors = $.parseJSON(response.responseText).errors
              for attribute, messages of errors
                alert "#{attribute} #{messages}" for message in messages






[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/vicmaster/list-backbone/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

