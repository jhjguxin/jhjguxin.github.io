---
layout: post
title: "How To: Allow users to sign in using their username or email address"
date: 2012-05-18 14:58
comments: true
categories: [rails,ruby]
tags: [devise]
---
## How To: Allow users to sign in using their username or email address
For this example, we will assume your model is called <code>User</code>
<h3>Create a username field in the <code>users</code> table</h3>
<ol>
	<li>Create a migration:
<div>
<pre> rails generate migration add_username_to_users username:string</pre>
</div></li>
	<li>Run the migration:
<div>
<pre> rake db:migrate</pre>
</div></li>
	<li>Modify the <code>User</code> model and add username to attr_accessible
<div>
<pre> attr_accessible :username</pre>
</div></li>
</ol>
<h3>Create a login virtual attribute in Users</h3>
<ol>
	<li>Add login as an attr_accessor
<div>
<pre># Virtual attribute for authenticating by either username or email
# This is in addition to a real persisted field like 'username'
attr_accessor :login</pre>
</div></li>
	<li>Add login to attr_accessible
<div>
<pre>attr_accessible :login</pre>
</div></li>
</ol>
<h3>Tell Devise to use :login in the authentication_keys</h3>
<ol>
	<li>Modify config/initializers/devise.rb to have:
<div>
<pre> config.authentication_keys = [ :login ]</pre>
</div></li>
</ol>
<ul>
	<li>If you are using multiple models with Devise, it is best to set the authentication_keys on the model itself if the keys may differ:
<div>
<pre>devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, 
       :validatable, :authentication_keys =&gt; [:login]</pre>
</div></li>
</ul>
<ol>
	<li>Overwrite Devise’s find_for_database_authentication method in Users model</li>
</ol>
<ul>
	<li>For ActiveRecord:
<div>
<pre> def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup
   login = conditions.delete(:login)
   where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value =&gt; login.strip.downcase }]).first
 end</pre>
</div></li>
	<li>For Mongoid:
Note: This code for Mongoid does some small things differently then the ActiveRecord code above. Would be great if someone could port the complete functionality of the ActiveRecord code over to Mongoid [basically you need to port the ‘where(conditions)’]. It is not required but will allow greater flexibility.
<div>
<pre>field :email

def self.find_for_database_authentication(conditions)
  login = conditions.delete(:login)
  self.any_of({ :username =&gt; login }, { :email =&gt; login }).first
end</pre>
</div></li>
</ul>
<ul>
	<li>For MongoMapper:
<div>
<pre>def self.find_for_database_authentication(conditions)
  login = conditions.delete(:login).downcase
  where('$or' =&gt; [{:username =&gt; login}, {:email =&gt; login}]).first
end</pre>
</div></li>
</ul>
<h3>Update your views</h3>
<ol>
	<li>Make sure you have the Devise views in your project so that you can customize them
Rails 3:
<div>
<pre> rails g devise:views</pre>
</div>
Rails 2:
<div>
<pre> script/generate devise_views</pre>
</div></li>
	<li>Modify the views
<ul>
	<li>sessions/new.html.erb:
<div>
<pre>-  &lt;p&gt;&lt;%= f.label :email %&gt;&lt;br /&gt;
-  &lt;%= f.email_field :email %&gt;&lt;/p&gt;
+  &lt;p&gt;&lt;%= f.label :login %&gt;&lt;br /&gt;
+  &lt;%= f.text_field :login %&gt;&lt;/p&gt;</pre>
</div></li>
	<li>registrations/new.html.erb
<div>
<pre>+  &lt;p&gt;&lt;%= f.label :username %&gt;&lt;br /&gt;
+  &lt;%= f.text_field :username %&gt;&lt;/p&gt;
   &lt;p&gt;&lt;%= f.label :email %&gt;&lt;br /&gt;
   &lt;%= f.email_field :email %&gt;&lt;/p&gt;</pre>
</div></li>
	<li>registrations/edit.html.erb
<div>
<pre>+  &lt;p&gt;&lt;%= f.label :username %&gt;&lt;br /&gt;
+  &lt;%= f.text_field :username %&gt;&lt;/p&gt;
   &lt;p&gt;&lt;%= f.label :email %&gt;&lt;br /&gt;
   &lt;%= f.email_field :email %&gt;&lt;/p&gt;</pre>
</div></li>
</ul>
</li>
</ol>
<h3>Manipulate the :login label that Rails will display</h3>
<ol>
	<li>Modify config/locales/en.yml to contain something like:
Rails 2:
<div>
<pre>activemodel:
  attributes:
    user:
      login: "Username or email"</pre>
</div>
Rails 3:
<div>
<pre>en:
  activerecord:
    attributes:
      user:  
        login: "Username or email"</pre>
</div></li>
</ol>
<h2>Allow users to recover their password using either username or email address</h2>
This section assumes you have run through the steps in Allow users to Sign In using their username or password.
<h3>Tell Devise to use :login in the reset_password_keys</h3>
<ol>
	<li>Modify config/initializers/devise.rb to have:
<div>
<pre> config.reset_password_keys = [ :login ]</pre>
</div></li>
</ol>
<h3>Overwrite Devise’s finder methods in Users</h3>
<ul>
	<li>For ActiveRecord:
<div>
<pre> protected

 # Attempt to find a user by it's email. If a record is found, send new
 # password instructions to it. If not user is found, returns a new user
 # with an email not found error.
 def self.send_reset_password_instructions(attributes={})
   recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
   recoverable.send_reset_password_instructions if recoverable.persisted?
   recoverable
 end 

 def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
   (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

   ###the has some error in my issue, my you should comment two line bellow
   attributes = attributes.slice(*required_attributes)
   attributes.delete_if { |key, value| value.blank? }

   if attributes.size == required_attributes.size
     if attributes.has_key?(:login)
        login = attributes.delete(:login)
        record = find_record(login)
     else  
       record = where(attributes).first
     end  
   end  

   unless record
     record = new

     required_attributes.each do |key|
       value = attributes[key]
       record.send("#{key}=", value)
       record.errors.add(key, value.present? ? error : :blank)
     end  
   end  
   record
 end

 def self.find_record(login)
   where(["username = :value OR email = :value", { :value =&gt; login }]).first
 end</pre>
</div></li>
	<li>For Mongoid:</li>
</ul>
<div>
<pre>def self.find_record(login)
  found = where(:username =&gt; login).to_a
  found = where(:email =&gt; login).to_a if found.empty?
  found
end</pre>
</div>
For Mongoid this can be optimized using a <a href="http://omarqureshi.net/posts/2010/06/17/mongoid-or-query/" rel="nofollow">custom javascript function</a>
<div>
<pre>def self.find_record(login)
  where("function() {return this.username == '#{login}' || this.email == '#{login}'}")
end</pre>
</div>
<ul>
	<li>For MongoMapper:</li>
</ul>
<div>
<pre>def self.find_record(login)
  (self.where(:email =&gt; login[:login]).first || self.where(:username =&gt; login[:login]).first) rescue nil
end</pre>
</div>
<h3>Update your views</h3>
<ol>
	<li>Modify the views
<ul>
	<li>passwords/new.html.erb:
<div>
<pre>-  &lt;p&gt;&lt;%= f.label :email %&gt;&lt;br /&gt;
-  &lt;%= f.email_field :email %&gt;&lt;/p&gt;
+  &lt;p&gt;&lt;%= f.label :login %&gt;&lt;br /&gt;
+  &lt;%= f.text_field :login %&gt;&lt;/p&gt;</pre>
</div></li>
</ul>
</li>
</ol>
<h2>Gmail or me.com Style</h2>
Another way to do this is me.com and gmail style. You allow an email or the username of the email. For public facing accounts, this has more security. Rather than allow some hacker to enter a username and then just guess the password, they would have no clue what the user’s email is. Just to make it easier on the user for logging in, allow a short form of their email to be used e.g “someone@domain.com” or just “someone” for short.
<div>
<pre>before_create :create_login

  def create_login             
    email = self.email.split(/@/)
    login_taken = User.where( :login =&gt; email[0]).first
    unless login_taken
      self.login = email[0]
    else	
      self.login = self.email
    end	       
  end

  def self.find_for_database_authentication(conditions)
    self.where(:login =&gt; conditions[:email]).first || self.where(:email =&gt; conditions[:email]).first
  end</pre>
</div>
For the Rails 2 version (1.0 tree): There is no <code>find_for_database_authentication</code> method, so use <code>self.find_for_authentication</code> as the finding method.
<div>
<pre>def self.find_for_authentication(conditions)
  conditions = ["username = ? or email = ?", conditions[authentication_keys.first], conditions[authentication_keys.first]]
  super
end</pre>
</div>
