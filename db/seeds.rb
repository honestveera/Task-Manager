#Create 10 tasks
(1..3).to_a.each do |user|
  User.create(first_name:"Test",last_name:"User#{user}",email:"honestraj.it#{user}@gmail.com",encrypted_password:"12345678")
 (1..10).to_a.each{|i| Task.create(id:i,title:"task#{i}",description:"New UI design#{i}",priority:i,user_id:user)}
end  