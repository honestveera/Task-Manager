

  user1 = User.create(id:1,first_name:"Test",last_name:"User1",email:"honestraj.it+1@gmail.com",password:"12345678",created_at:Time.now, updated_at: Time.now)
  user2 = User.create(id:2,first_name:"Test",last_name:"User2",email:"honestraj.it+2@gmail.com",password:"12345678",created_at:Time.now, updated_at: Time.now)
  user3 = User.create(id:3,first_name:"Test",last_name:"User3",email:"honestraj.it+3@gmail.com",password:"12345678",created_at:Time.now, updated_at: Time.now)
  admin =  User.create(id:4,first_name:"Test",last_name:"User1",email:"honestraj.it@gmail.com",admin:true,password:"12345678",created_at:Time.now, updated_at: Time.now)

  1.upto(20) do |i|
    Task.create(id:i,
    title: "Task#{i}",
    description: "UI design#{i}",
    priority: 1,
    due_date: Time.now,
    assign_user_id: 1,
    status: "open",
    user_id: "#{i<=10 ? 1 : 2}",
    created_at: Time.now,
    updated_at: Time.now)
  end