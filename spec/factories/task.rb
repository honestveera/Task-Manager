FactoryGirl.define do
  factory :task do
    title         { Faker::App.name }
    description   { Faker::Lorem.sentences(2) }
    priority      { Faker::Number.between(1, 10) }
    due_date      { Faker::Time.forward(23, :all) }
    status        {Faker::Boolean.boolean(0.2) }
    assign_user_id 1
    user
  end
end