  #!usr/bin/bash
  echo "*******Bundel install*********"
  bundle install
  echo "*******RVM version and gemset*********"
  rvm use 2.3.1@ruby231
  echo "*******DB Setup*********"
  rake db:drop
  rake db:create
  rake db:migrate
  rake db:schema:load
  rake db:seed
  echo "*******Assets Precompile *********"
  rake assets:precompile