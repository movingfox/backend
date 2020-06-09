# backend
Rails application template for a backend server

# How to create a new application with this template

Rails' `new` command options, or you can reate or modify the text file `~/.railsrc` containing

    --skip-coffee
    --skip-spring
    --webpack=stimulus
    -d postgresql

Then, create a new application named `site` for example by

    rails new site -m backend/template.rb

That's it.
