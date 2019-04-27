# Advertize
### Objective
**Advertize** is a database driven application for advertisement managing. Users may post advertisements with details, and administrators may choose to support or decline pending advertisements as they see fit.

### Setup
To start your Phoenix server with the **automated** method:
1. Clone repository and `cd` into the main folder.
2. Initiate dependency installs, database creation and migration and server startup via the following command: `./runner stetup`


To start your Phoenix server with the **manual** method:
  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3.  Install Node.js dependencies with `cd assets && npm install`
  4. Start Phoenix endpoint with `mix phx.server`

Should you desire to stop the server, press `ctrl + c` twice.

### Running
You may run the server one of two ways:
1. `cd` into the main project directory and use the command `mix phx.server` to run the server.
2. `cd` into the main project directory and use the command `./runner start` to update all dependencies, migrate any changes to the database you've made since the last run, etc.

To be safe, the 2nd way is recommended especially if you're pulling changes or have made updates to database or node modules.


### Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
