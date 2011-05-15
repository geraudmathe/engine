=begin
account = Account.create! :name => 'Admin', :email => 'admin@example.com', :password => 'locomotive', :password_confirmation => 'locomotive'

site = Site.new :name => 'Locomotive test website', :subdomain => 'test'
site.memberships.build :account => account, :admin => true
site.save!

puts "Your first website has been created !"
puts "Admin url: http://test.example.com:3000/admin"
puts "Crendetials: admin@example.com / locomotive"
=end
#puts 'EMPTY THE MONGODB DATABASE'
#Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
#puts 'SETTING UP DEFAULT USER LOGIN'
(1..100).each do |n|
  user = User.create! :firstname => "firstname-#{n}",:lastname => "lastname-#{n}", :email => "user#{n}@test.com", :password => "please", :password_confirmation => "please"
  puts 'New user created: ' << user.firstname
end