Fabricator(:user) do
  username { sequence(:username) { |i| "gemini#{i}"} }
  email { sequence(:email) { |i| "vera@gemini#{i}.com"} }
  password "marie"
end
