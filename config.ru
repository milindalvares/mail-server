require 'rubygems'
require 'bundler'
require 'sinatra'
require 'rack'


set :root, Pathname(__FILE__).dirname
set :environment, :production
set :run, false