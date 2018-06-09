#!/bin/bash

NAME=${1:-}

if [ -z "$NAME" ]; then
  echo "must specify name"
  exit
fi

rails new $NAME --webpack=react --database=postgresql -T

cd "./"$NAME

bundle inject byebug "~>10.0.2" --group "development, test"
bundle inject webmock "~> 3.3.0" --group "test" 
bundle inject rubocop "~> 0.57.1" --group "development, test" 
bundle inject bullet "~> 5.7.2" --group "development" 
bundle inject factory_bot_rails "~> 4.8.2" --group "test" 
bundle inject rspec-rails "~> 3.7.2" --group "development, test" 
bundle inject sidekiq "~> 5.0.5"

bundle install

rails generate rspec:install

rubocop --auto-gen-config
rubocop -a

brew install yarn
yarn add axios
yarn add jest
yarn add moment
yarn add prop-types