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

post '/contact/:account' do
	account = "goobimama@me.com"
	
	if params[:account] == "hashcookies"
		account = "milind@hashcooki.es"
		account_subject = "Hash Cookies Form"
	elsif params[:account] == "yellowledger"
		account = "milindalvares@me.com"
		account_subject = "Yellow Ledger Form"
	end
	
	name = params[:name]
	email = params[:email]
	phone = params[:phone]
	project_type = params[:project_type]
	message = params[:message]
	cm_original = params[:original]
	page_url = request.referrer
	
	body = ""
	body << "<strong>Name:</strong> #{name}<br />" unless name.nil?
	body << "<strong>Email:</strong> #{email}<br />" unless email.nil?
	body << "<strong>Phone:</strong> #{phone}<br />" unless phone.nil?
	body << "<strong>Project Type:</strong> #{project_type}<br />" unless project_type.nil?
	body << "<strong>Original Message:</strong> #{cm_original}<br />" unless name.nil?
	body << "<strong>Message:</strong><br /> #{message}<br />" unless message.nil?
	body << "<br />Sent From Page: #{page_url}"
	
	Pony.mail(
		:from => "#{name}<milind@hashcooki.es>",
		:to => account,
		:subject => account_subject,
		:html_body => body,
		:via => :smtp,
		:via_options => {
			  :address              => 'smtp.sendgrid.net', 
	        :port                 => '587', 
				:user_name            => 'milind@hashcooki.es', 
				:password             => 'N_y81H9kFFX5E9DObShfLA',  
	        :authentication       => :plain
		}
	)
	return true
end