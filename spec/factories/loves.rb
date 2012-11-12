# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lofe, :class => 'Love' do
    song_id 1
    user_id 1
  end
end
