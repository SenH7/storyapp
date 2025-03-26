puts "Clearing existing data..."
Comment.destroy_all
Post.destroy_all
PersonalInformation.destroy_all
User.destroy_all

puts "Creating users..."
user1 = User.create!(
  email: "john@example.com",
  password: "password123",
  password_confirmation: "password123"
)

user1.create_personal_information!(
  username: "JohnWriter",
  city: "New York",
  country: "USA"
)

user2 = User.create!(
  email: "sarah@example.com",
  password: "password123",
  password_confirmation: "password123"
)

user2.create_personal_information!(
  username: "SarahStories",
  city: "London",
  country: "UK"
)

user3 = User.create!(
  email: "mike@example.com",
  password: "password123",
  password_confirmation: "password123"
)

user3.create_personal_information!(
  username: "MikeReads",
  city: "Sydney",
  country: "Australia"
)

puts "Creating posts..."
post1 = user1.posts.create!(
  title: "The Mysterious Lighthouse",
  content: "The lighthouse stood tall against the stormy horizon, its beam cutting through the dense fog. For decades it had guided ships safely to shore, but tonight something was different. The light flickered in an unusual pattern, almost as if it was sending a message. Captain James narrowed his eyes, trying to decipher what seemed like an ancient code. His ship rocked violently as the waves grew higher, pushing him closer to the jagged rocks that surrounded the small island. He had to make a decision quickly: trust the lighthouse as sailors had done for generations, or change course based on his instincts that something was terribly wrong."
)

post2 = user1.posts.create!(
  title: "Urban Whispers",
  content: "The city never truly sleeps; it just speaks in different voices throughout the night. During the day, it's the cacophony of car horns, construction, and countless conversations. But at 3 AM, it's the hum of distant highways, the occasional siren, and the soft padding of stray cats across fire escapes. Maria had lived here for twenty years, and she had learned to hear the whispers that others missed. Tonight, the whispers told her something was coming—something that would change the rhythm of the streets she called home."
)

post3 = user2.posts.create!(
  title: "The Last Letter",
  content: "The envelope was yellowed with age, the handwriting faded but still legible. Emma traced her finger over her grandmother's elegant script, addressing a man she had never heard of. The letter had been hidden in a secret compartment of the antique desk she had inherited, along with a black and white photograph of a young soldier. 'My dearest Thomas,' the letter began, 'If you are reading this, it means I found the courage to finally tell you the truth.' Emma's hands trembled. What truth had her grandmother kept hidden for all these years?"
)

post4 = user3.posts.create!(
  title: "Digital Memories",
  content: "They said the memory implant would change his life, and they were right—just not in the way Alex had expected. The procedure was supposed to help him with his exams, downloading information directly into his brain. But something had gone wrong. Now he was experiencing memories that weren't his: a childhood in a country he had never visited, a love for someone he had never met, and increasingly, knowledge of a crime he couldn't possibly have committed. The memories felt as real as his own, and they were getting stronger every day."
)

# Create sample comments
puts "Creating comments..."
post1.comments.create!(
  user: user2,
  content: "This is captivating! I can almost feel the stormy waves and sense the captain's dilemma. Will there be a part two?"
)

post1.comments.create!(
  user: user3,
  content: "Your description of the lighthouse is so vivid. I'm curious to know what message the light is trying to convey!"
)

post2.comments.create!(
  user: user3,
  content: "As someone who also lives in a big city, you've captured that late-night urban atmosphere perfectly."
)

post3.comments.create!(
  user: user1,
  content: "What a compelling opening to a story! The mystery of the letter and the hidden truth has me hooked."
)

post3.comments.create!(
  user: user3,
  content: "Family secrets across generations always make for fascinating stories. I hope Emma discovers the truth!"
)

post4.comments.create!(
  user: user1,
  content: "This concept is mind-blowing! It reminds me of some of Philip K. Dick's work on memory and identity."
)

post4.comments.create!(
  user: user2,
  content: "I'm intrigued by the ethical implications here. Who is responsible for actions taken based on someone else's implanted memories?"
)

puts "Seed data created successfully!"
