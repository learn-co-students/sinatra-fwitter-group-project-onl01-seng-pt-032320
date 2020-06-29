tweet1 = Tweet.create(content: "This tweet is new 1")
tweet2 = Tweet.create(content: "This tweet is new 2")
tweet3 = Tweet.create(content: "This tweet is new 3")
tweet4 = Tweet.create(content: "This tweet is new 4")
tweet5 = Tweet.create(content: "This tweet is new 5")
tweet6 = Tweet.create(content: "This tweet is new 6")
tweet7 = Tweet.create(content: "This tweet is new 7")
tweet8 = Tweet.create(content: "This tweet is new 8")

user1 = User.create(username: "onlyone", password: "password1", email: "thisemail1@gmail.com")
user2 = User.create(username: "onlytwo", password: "password2", email: "thisemail2@gmail.com")

user1.tweets << tweet1
user1.tweets << tweet2
user1.tweets << tweet3
user1.tweets << tweet4

user2.tweets << tweet5
user2.tweets << tweet6
user2.tweets << tweet7
user2.tweets << tweet8