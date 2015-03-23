require 'sinatra'
require 'rubygems'
require 'pony'
require 'sinatra/cross_origin'

configure do
	enable :cross_origin
end

get '/hi' do
	erb :home
end

get '/' do
	"Hello"
end

post '/contact' do
	name = params[:name]
	project_type = params[:project_type]
	email = params[:email]
	phone = params[:phone]
	message = params[:message]
	cm_original = params[:original]
	Pony.mail(
		:from => "#{name}<milind@hashcooki.es>",
		:to => 'milind@hashcooki.es',
		:subject => "Hash Cookies Request",
		:html_body => "Project Pype: #{project_type}<br /> Message: #{message}<br /> Phone: #{phone}<br /> email: #{email}<br /> Original: #{cm_original}",
		:via => :smtp,
		:via_options => {
			  :address              => 'smtp.sendgrid.net', 
	        :port                 => '587', 
	        :user_name            => '', 
	        :password             => '', 
	        :authentication       => :plain
		}
	)
	return true
end