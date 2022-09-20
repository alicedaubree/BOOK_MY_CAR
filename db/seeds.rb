# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all
Car.destroy_all


user_evan = User.new(
  email: "evan@evan.com",
  password: "xxxxxx",
  first_name: "Evan",
  last_name: "Abaella"
)
profile_pic = URI.open("https://i.imgur.com/KvGhU6H.jpg")

user_evan.photo.attach(io: profile_pic, filename: "profile.jpg", content_type: "image/jpg")

user_evan.save


user_silvia = User.new(
  email: "silvia@silvia.com",
  password: "xxxxxx",
  first_name: "Silvia",
  last_name: "Pasini"
)

profile_pic = URI.open("https://i.imgur.com/PSEZuno.jpg")

user_silvia.photo.attach(io: profile_pic, filename: "profile.jpg", content_type: "image/jpg")

user_silvia.save



user_olivier = User.new(
  email: "olivier@olivier.com",
  password: "xxxxxx",
  first_name: "Olivier",
  last_name: "Barthelemy"
)

profile_pic = URI.open("https://i.imgur.com/V2OjIT9.jpg")

user_olivier.photo.attach(io: profile_pic, filename: "profile.jpg", content_type: "image/jpg")

user_olivier.save

5.times do
  car = Car.new(
  title: Faker::Vehicle.make_and_model,
  description: "I propose a #{Faker::Vehicle.color} #{Faker::Vehicle.model} with a #{Faker::Vehicle.engine} engine working with #{Faker::Vehicle.fuel_type} and made by #{Faker::Vehicle.manufacture} in #{Faker::Vehicle.year}",
  price_per_day: rand(15..30),
  places: rand(1..5),
  mileage: Faker::Vehicle.mileage,
  gearbox: Faker::Vehicle.drive_type,
  air_conditionning: [true, false].sample,
  user_id: [user_olivier.id, user_silvia.id, user_evan.id].sample,
  address: ["Chateau de Crémat", "22 rue bottero", "Aeroport de Nice", "Haut de Gambetta"].sample,
)
car_pic = URI.open(["https://auto-vicoigne-transaction.com/wp-content/uploads/2020/12/IMG_6112-1200x750.jpeg","https://freuromoney.com/wp-content/uploads/2020/10/a58e9dbe7fd6bd460571092defade1fc_clio-2460877_1920.jpg", "https://www.ouestfrance-auto.com/sites/default/files/160301_fiat_500s_01.jpg", "https://images.caradisiac.com/logos/4/5/0/4/194504/S0-europe-la-berline-premium-se-vend-mieux-que-la-generaliste-111778.jpg", "https://photo-voiture.motorlegend.com/hd/ferrari-f8-tributo-v8-3-9-720-ch-123063.jpg"].sample)
car.photo.attach(io: car_pic, filename: "pic.jpg", content_type: "image/jpg")
car.save!
end

# car1_pic1 = URI.open("https://urbexsession.com/wp-content/uploads/2018/05/chateau-pierre-chanal-5.jpg")
# car1.photos.attach(io: car1_pic1, filename: "pic1.jpg", content_type: "image/jpg")
# car1_pic2 = URI.open("https://i.pinimg.com/736x/ca/6e/77/ca6e7739d4a060d6049893a7801146dd.jpg")
# car1.photos.attach(io: car1_pic2, filename: "pic2.jpg", content_type: "image/jpg")

# car1.save!
