require 'faker'

# Create 150 topics
topics = []
150.times do
  topics << Topic.create(
    name: Faker::Lorem.words(rand(1..10)).join(" "),
    description: Faker::Lorem.paragraph(rand(1..4))
  )
end

rand(10..15).times do
  password = Faker::Lorem.characters(10)
  u = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password)
  u.skip_confirmation!
  u.save
end

User.all.each do |u|
  rand(80..100).times do
    topic = topics.first # getting the first topic here
    p = u.posts.create(
      topic: topic,
      title: Faker::Lorem.words(rand(1..10)).join(" "),
      body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
    post_creation_time = Time.now - rand(600..31536000) # set created_at to a time within the past year
    p.update_attribute(:created_at, post_creation_time)
    
    topics.rotate! # add this line to move the first topic to the last, so that posts get assigned to different topics.

    rand(3..7).times do
      c = p.comments.create(
        user: User.order("RANDOM()").first, # randomly select a user which the comment belongs to
        body: Faker::Lorem.paragraphs(rand(1..2)).join("\n"))
      c.update_attribute(:created_at, [post_creation_time + rand(60..31536000), Time.now].min) # set created_at to within one year since the post creation time
    end
  end
end

u = User.new(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'admin')

u = User.new(
  name: 'Moderator User',
  email: 'moderator@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'moderator')

u = User.new(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
