<h1 align="center"><b>Rails Chat App</b></h1>

**Simpul Tech**: Skill Challenge.
</br>
https://simpul.tech/
</br>

**Challenge**:
</br>
Create a simple real-time chat web application using Ruby on Rails and deploy it online.

**Basic Requirements**:
- [x] Create a chatroom
- [x] Post messages with real-time update to the view
- [x] Host it online, so anyone can view the project by clicking a link.

**Plus points**:
- [x] Implement unit tests
- [x] Implement tasteful UI
- [ ] ~~Use modern JS frontend eg. React/Vue~~

Note: there is no need to do user authentication etc.

## Tech Stack

| Technologies       | Version           |
| ------------------ | ----------------- |
| Ruby (RVM)         | v3.1.2 (v1.29.12) |
| Ruby On Rails      | v7.0.4            |
| PostgreSQL         | v14.10            |
| Bootstrap          | v4.1.3            |

## Used Gems

| Dependencies   | Gems              |
| -------------- | ----------------- |
| Login/Register | devise            |
| Real-time Data | turbo-rails       |
| ERD            | rails-erd         |
| Testing        | rspec-rails       |
| Object Dummy   | factory_bot_rails |
| Coverage       | simplecov         |
| Debugging      | byebug            |

## Usage

1. Create rails local credentials. If using VS Code as code editor write this command:
   ```bash
   EDITOR="code --wait" rails credentials:edit
   ```
   Add these line and adjust it with your local database configuration:
   ```yaml
   postgresql:
     rails_max_threads: 5
     database_url_dev: "postgresql://username:password@localhost:5432/db_dev?schema=public"
     database_url_test: "postgresql://username:password@localhost:5432/db_test?schema=public"
   ```
   Then save it.
   
2. run `bundle install`.
3. run `rails db:create db:migrate`.
4. run `rails s`.

## Entity Relational Database

Generate ERD file using GraphVIZ and run `bundle exec erd`.

![erd](/app/assets/images/erd.png)

## Deployment

This app has been deployed at: https://rails-chat-app-3hl7.onrender.com/