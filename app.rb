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

post '/secretsanta/' do
	name = params[:name]
	account = params[:email]
	message = params[:message]
	assigned = params[:assigned]
	recepient_hash = params[:recepient_hash]

	body = ""
	body << "Hi <strong>#{name}</strong>, you are secret santa to #{assigned}. <br /><br />" unless name.nil?
	body << "You also have a secret santa of your own! You can't know who they are but you can write them a wishlist by <a href='http://hashcooki.es/secret-santa/send-wishlist/#{recepient_hash}'>clicking this link.</a><br /><br />" unless recepient_hash.nil?
	body << "#{message}<br /><br />" unless message.nil?
	body << "<small>You're receiving this email because someone entered your email and name in the <a href='http://hashcooki.es/secret-santa'>secret santa randomiser</a>. You are not subscribed to any mailing list.</small><br />"

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

post '/secretsanta-wishlist/' do
	account = params[:recipient]
	message = params[:message]
	body = ""
	body << "Hi, your Secret Santa Assignee (Santee, for short) has sent you this message…<br /> #{message}" unless message.nil?

	Pony.mail(
 	 :from => "Hash Cookies Secret Santa<noreply@hashcooki.es>",
 	 :to => account,
 	 :subject => "Dear Santa...",
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
