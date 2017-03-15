# Demo Application

In this demo application, I'm going to go step by step through the installation.
The application will show the dives that are planned in a scuba diving club.
For every dive, there is a diving location, and also participants.

# Create API using Loopback
## Install Loopback and setup API

First we install the required commands

    $ npm install -g loopback-cli
        [.......]

After the installation has finished, a new command should be added to your path: `lb`.
This utility will help us to configure our API.

    $ lb
    
             _-----_    
            |       |    ╭──────────────────────────╮
            |--(o)--|    │ Let's create a LoopBack  │
           `---------´   │       application!       │
            ( _´U`_ )    ╰──────────────────────────╯
            /___A___\   /
             |  ~  |     
           __'.___.'__   
         ´   `  |° ´ Y ` 
        
        ? What's the name of your application? demo-api
        ? Enter name of the directory to contain the project: demo-api
           create demo-api/
        
        ? Welke versie van LoopBack wilt u gebruiken? 3.x (current)
        ? What kind of application do you have in mind? empty-server (An empty LoopBack API, without any configured models or datasources)
        
        
        I'm all done. Running npm install for you to install the required dependencies.
        If this fails, try running the command yourself.
        
        
           create .editorconfig
           create .eslintignore
           create .eslintrc
           create server/boot/root.js
           create server/middleware.development.json
           create server/middleware.json
           create server/server.js
           create README.md
           create server/boot/authentication.js
           create .gitignore
           create client/README.md
           
        [.......]
        
        Next steps:
        
          Go to the directory for our app
            $ cd demo-api
        
          Make a model in your app
            $ lb model
        
          Execute the app
            $ node .

## Run API

As the output of the previous section already told us, we now need to start the application.

    $ cd demo-api
    $ node .
        Web server listening at: http://0.0.0.0:3000
        Browse your REST API at http://0.0.0.0:3000/explorer

**Your API is now running !**

When you navigate to these URLs in your preferred browser, you will see following information:

* `http://localhost:3000`: The uptime of the server
* `http://localhost:3000/explorer`: An explorer window to test your API calls

In the explorer, there isn't a lot to see for the moment.
We don't have any data in it yet.

## Add some connections to the database

We first add a new connection to the database we want to use.
So we can add models based on this database connection.

    $ lb datasource
    ? Enter the data-source name: postgres-db
    ? Select the connector for oracledb: PostgreSQL (supported by StrongLoop)
    Connector specific configuration:
    ? Connection String url to override other settings (eg: postgres://username:password@localhost/database): postgres://postgres:postgres@localhost/mantis
    ? host: localhost
    ? port: 5432
    ? user: postgres
    ? password: ********
    ? database: mantis
    ? install loopback-connector-postgresql@^2.4 Yes

Adding this datasource, will make sure that we can use it from now on to define our models.

## Define the models

Like in Hibernate, you have to make models for your objects in the database.
Those models explain how your data is linked together. 

Let's create our models.

    $ lb model
    ? Enter the model name: dive
    ? Select the data-source to attach dive to: postgres-db (postgresql)
    ? Select model's base class PersistedModel
    ? Expose dive via the REST API? Yes
    ? Custom plural form (used to build REST URL): dives
    ? Common model or server only? common
    Let's add some dive properties now.
    
    Enter an empty property name when done.
    ? Property name: id
       invoke   loopback:property
    ? Property type: number
    ? Required? Yes
    ? Default value [leave empty for none]: 
    
    [.....]

There are a lot of predefined base classes that can be used to link your model to:
ACL, AccessToken, Application, Change, Checkpoint, Email, KeyValueModel, Role, RoleMapping, Scope, User.
Those classes will then be used to setup inheritance, just like the `extends` keyword in Java.
If you would have already defined other custom classes, the list would also contain them.
For the case of `dive` it will inherit the properties from `PersistedModel`.
That's what we want, because the model defines the methods so we can execute updates, selects etc.

In Loopback they use small caps for names of custom classes, and CamelCase for predefined classes.

Define the other models and properties in the same way as above, just follow the steps.

Stop and restart `node .` if still running, so the new settings will be used.
 
If you navigate to `localhost:3000/explorer` the new endpoints will be visible.

### Define PostgreSQL information

The `lb` tries to do as much as possible, but there are still some things it won't yet do.
For example, because PostgreSQL is used, a database schema is required.
We haven't given that information yet.

In `demo-api/common/models/dive.json` add the following to the `options` key:

```json
"postgresql": {
  "schema": "mantis",
  "table": "dives"
}
```
    
For the `dive.json`, this becomes:

```json
{
  "name": "dive",
  "plural": "dives",
  "base": "PersistedModel",
  "idInjection": true,
  "options": {
    "validateUpsert": true,
    "postgresql": {
      "schema": "mantis",
      "table": "dives"
    }
  },
  "properties": {
    "id": {
      "type": "number",
      "required": true
    },
    "name": {
      "type": "string",
      "required": true
    },
    "date": {
      "type": "date"
    },
    "location_id": {
      "type": "number",
      "required": true
    }
  },
  "validations": [],
  "relations": {},
  "acls": [],
  "methods": {}
}
```

Do accordingly for the other models.

Stop and restart `node .` if still running, so the new settings will be used.

If you navigate to `localhost:3000/explorer` and try a `GET` call the correct results will be returned.

## Result

We actually have an API now that we can use for our application.
We can start executing all different commands on the API and everything will be persisted in the database.

# Requesting information

Now that the basic API is set up, requesting data can be tested.

Testing using the explorer is a good way to start.
Go to `localhost:3000/explorer` in your favorite browser (the server should of course be running).
The endpoints that were configured, are listed on this page.
If you click on an endpoint, all the possible operations are listed, and the method that will be used to request the
information (or update the server).
Clicking on a possible operation will open some more information.
Showing the information that you can request, or the information that you need to provide.
Clicking on "Try it out!" will execute the operation on the server.
The result (if any) of the operation will appear on the screen.
The request URL that was used is listed, together with the curl command to execute it on the command line.

In the case of the `dives` endpoint, a GET `/dives` will return all the dives in the database.

Playing around with the explorer really helps in understanding how the API works and how everything is linked together.

## Filters

If you work with large datasets, sooner or later the requirement will pop up to do some filtering.
Every basic call is therefor provided with the basic filtering options: fields, where, include, order, offset and limit.

So you select which `fields` you want to have returned,
or select only the values that meet a certain condition using `where`.
Or what about `order`ing and `limit`ing the values.
 
More information can be found on the
[tutorial page of the Loopback site](http://loopback.io/doc/en/lb3/Querying-data.html).

# Let's go further !

## Add links between models

In the database we're using, some database tables are linked together.
So it would be fun if we could load the participants of a specific dive for example.

Easy, just add a relation in Loopback.
And as you would expect, Loopback has a command for that too.

    $ lb relation
    ? Name of the model to create the relationship from:  dive
    ? Relation type: has many
    ? Name of the model to create a relationship with: participant
    ? Name for the relation: participants
    ? Custom foreign key: dive_id
    ? Whether a "through" model is required? No

Stop and restart `node .` if still running, so the new settings will be used.

Reloading the `localhost:3000/explorer` URL will now show even more possible calls for the `dives` endpoint.
You can now also easily request the participants linked to a dive.

The same can be done between the dive and the location.

## User implemented methods

Sometimes the actions that should be executed, are more advanced, or require access to multiple endpoints.
The solution for these problems are "remote methods".

Using a remote method, a new operation is added to the selected endpoint.
The implementation of this operation is written in the `/common/models/<endpoint>.js` file.

It's possible to execute the basic actions of the model on the object itself.
Every model has several methods that can be used, among others: `create`, `find`, `findOne`, `updateAll`, `updateAttribute`,
`createUpdates`, `destroyAll`. 

For example:

```javascript
/**
 * Find the planned dives for the given country.
 * @param country the country for which the dives should be returned
 * @param cb      callback function, for asynchronous access. First parameter is the error (or null if none),
 * the second parameter is the result.
 */
Dive.divesByCountry = function (country, cb) {
    var Location = app.models.location;

    Location.find({fields: ["id"], where: {location: country}}, function (err, locations) {
        var locationIds = [];
        for (var i = 0, length = locations.length; i < length; i++) {
            locationIds.push(locations[i].id);
        }
        Dive.find({where: {location_id: {"inq": locationIds}}}, cb);
    })
};

Dive.remoteMethod('divesByCountry', {
    accepts: {arg: 'country', type: 'string'},
    returns: {arg: 'dives', type: 'Dive[]'}
});
```

## Security !

It makes sense that you want to protect your application from unauthorized access.
Loopback has its own built in system that allows user management.

## Debugging

There will probably come a time, you will need debugging of the queries that are begin executed.
The easiest way to do this, is by using the command `DEBUG=loopback:connector:postgresql node .` instead of just 
`node .`.
After executing this command, the executed queries of the PostgreSQL connector will be printed to the console.
Of course you can also change the path in the `DEBUG` parameter to some other connector, or another component.


# Now some more automatic way

So far all we did was manual configuration of the services.
But there is a more automatic way too, by using the
[IBM API Connect](http://www-03.ibm.com/software/products/en/api-connect) service.
This option isn't free though, so that is the reason I manually configure it for most applications.

# More information

* You can disable the explorer if you want (security reasons)
* Requirements:
    * Node.js 4.x or higher
* More information: http://loopback.io/
    

# Build demo website

    $ ng new demo-website
    $ cd demo-website
    $ ng serve