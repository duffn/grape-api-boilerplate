user1 = User.create(email: 'grape_user@example.com', username: 'grape_user', password: 'grape_user1')
user2 = User.create(email: 'grape_user2@example.com', username: 'grape_user2', password: 'grape_user2')

100.times do |i|
  Widget.create(name: "Widget ##{i}", user_id: [user1.id, user2.id].sample)
end
