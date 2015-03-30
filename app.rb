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
	account = "milind@hashcooki.es"
	alt_account = ""
	
	if params[:account] == "hashcookies"
		account = "fresh@hashcooki.es"
		alt_account = "milind@hashcooki.es"
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
	form_id = params[:form_id]
	
	body = ""
	body << "<strong>Name:</strong> #{name}<br />" unless name.nil?
	body << "<strong>Email:</strong> #{email}<br />" unless email.nil?
	body << "<strong>Phone:</strong> #{phone}<br />" unless phone.nil?
	body << "<strong>Project Type:</strong> #{project_type}<br />" unless project_type.nil?
	body << "<strong>Original Message:</strong> #{cm_original}<br />" unless name.nil?
	body << "<strong>Message:</strong><br /> #{message}<br />" unless message.nil?
	body << "<br />Sent From Page: #{page_url}<br />"
	body << "Form ID: #{form_id}"
	
	Pony.mail(
		:from => "Hash Cookies Form Mailer<noreply@hashcooki.es>",
		:to => account,
		:bcc => alt_account,
		:subject => account_subject,
		:html_body => body,
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