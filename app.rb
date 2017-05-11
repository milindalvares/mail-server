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

		account = "support@yellowledger.com"
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
	website = params[:website]

	body = ""
	body << "<strong>Name:</strong> #{name}<br />" unless name.nil?
	body << "<strong>Email:</strong> #{email}<br />" unless email.nil?
	body << "<strong>Phone:</strong> #{phone}<br />" unless phone.nil?
	body << "<strong>Project Type:</strong> #{project_type}<br />" unless project_type.nil?
	body << "<strong>Original Message:</strong> #{cm_original}<br />" unless cm_original.nil?
	body << "<strong>Website:</strong> #{website}<br />" unless website.nil?
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

post '/secretsanta/:account' do
	account = params[:account]

	name = params[:name]

	body = ""
	body << "<strong>You have been assigned</strong> #{name}<br />" unless name.nil?

	Pony.mail(
		:from => "Hash Cookies Secret Santa<noreply@hashcooki.es>",
		:to => account,
		:subject => "Secret Santa Assignment",
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

post '/gmm-volunteer/' do

	to = params[:to]
	name = params[:fullname]
	contact = params[:contact]
	worktime = params[:worktime]
	body = ""
	body << "<strong>Name</strong> #{name}" unless name.nil?
	body << "<strong>Contact</strong> #{contact}" unless contact.nil?
	body << "<strong>Name</strong> #{worktime}" unless worktime.nil?

	Pony.mail(
		:from => "Hash Cookies Secret Santa<noreply@goenchimati.org>",
		:to => account,
		:subject => "Message From Goenchimati Volunteer",
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
