---
layout: post
title: "factory_girl Validation failed"
date: 2012-03-16 16:22
comments: true
categories: ["rails", "ruby"]
tags: ["factory_girl", "failed", "Validation"]
---
## factory_girl Validation failed
You need to use a sequence to prevent the creation of user objects with the same email, since you must have a validation for the uniqueness of emails in your User model.
<pre><code>Factory.sequence :email do |n|
  “test#{n}@example.com”
end

Factory.define :user do |user|
  user.name "Testing User"
  user.email { Factory.next(:email) }
  user.password "foobar"
  user.password_confirmation "foobar"
end
</code></pre>
You can read more in the <a href="https://github.com/thoughtbot/factory_girl/wiki/Usage" rel="nofollow">Factory Girl documentation</a>.

&nbsp;

Using factory_girl to create several instances of a class that belongs to another class causes a Validation failed error.

This happens because each instance tries to automatically create the object to which it belongs. However since the first instance creates it, the following instances crash because the object already exists.

I have been struggling to solve this problem and it seems finally I arrived to a satisfactory solution.

The problem arises when there is a one to many relationship between to classes and I try to create several instances of a class.

In my case I have a subdomain which has many users:

class Subdomain &lt; ActiveRecord::Base validates_uniqueness_of :name, :case_sensitive =&gt; false
has_many :users
end
class User &lt; ActiveRecord::Base belongs_to: subdomain endThe factories are as follows: FactoryGirl.define do factory :subdomain do name 'test-subdomain' end factory :user do subdomain email 'test-user@example.com' password '123456¿ password_confirmation '123456' end endWhen I try to create two users using the following code: FactoryGirl.create(:user, :email =&gt; "first@example.com")
FactoryGirl.create(:user, :email =&gt; "second@example.com")I get the following error:

Validation failed: Name has already been taken (ActiveRecord::RecordInvalid)This happens because when the first user is created, the default subdomain is created too and when the second user is created the subdomain already exists.

If we want to use the same subdomain for both users we can do the following:

s = FactoryGirl.create(:subdomain)
FactoryGirl.create(:user, :email =&gt; "first@example.com", :subdomain =&gt; s)
FactoryGirl.create(:user, :email =&gt; "second@example.com", :subdomain =&gt; s)However as our has_many relations become deeper, test data creation becomes more complex.

My solution to this problem is as to change the factory for user:

factory :user do
subdomain { Subdomain.find_by_name('test-subdomain') || FactoryGirl.create(:subdomain) }
email 'test-user@example.com'
password '123456'
password_confirmation '123456'
endIn this case the factory uses the default subdomain if it already exists, avoiding the validation problem.

Now if we use the initial code, it works without problem, assigning both users to the default subdomain

FactoryGirl.create(:user, :email =&gt; "first@example.com")
FactoryGirl.create(:user, :email =&gt; "second@example.com")However this does not limit us to use the same subdomain for all users:

other_subdomain = FactoryGirl.create(:subdomain, :name =&gt; "other-subdomain")

FactoryGirl.create(:user, :email =&gt; "first@example.com", :subdomain =&gt; other_subdomain)
FactoryGirl.create(:user, :email =&gt; "second@example.com")In this case, the first user is assigned to other-subdomain and the second user is assigned to test-subdomain.
