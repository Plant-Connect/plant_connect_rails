
User.destroy_all
Plant.destroy_all
Listing.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('plants')
ActiveRecord::Base.connection.reset_pk_sequence!('listings')

user1 = User.create(username: 'Aedan', email: 'aedan@test.com', password: '123password', password_confirmation: '123password', location: 'Denver County, CO')
user2 = User.create(username: 'Brenda', email: 'brenda@test.com', password: 'password123', password_confirmation: 'password123', location: 'Denver County, CO')
user3 = User.create(username: 'Emily', email: 'cathleencorcoran@gmail.com', password: 'plantconnect', password_confirmation: 'plantconnect', location: 'Denver County, CO')
user4 = User.create(username: 'Jerry', email: 'planty.raid@yahoo.com', password: 'madprops', password_confirmation: 'madprops', location: 'Denver County, CO')
user5 = User.create(username: 'Katie', email: 'StevenJamesSTL@gmail.com', password: 'seedly', password_confirmation: 'seedly', location: 'Jefferson County, CO')
user6 = User.create(username: 'Katie', email: 'katie_t@test.com', password: 'stemswap', password_confirmation: 'stemswap', location: 'Jefferson County, CO')
user7 = User.create(username: 'Paul', email: 'paul@test.com', password: 'plantydropper', password_confirmation: 'plantydropper', location: 'Jefferson County, CO')
user8 = User.create(username: 'Steven', email: 'HireStevenJames@gmail.com', password: 'nogreenthumbs', password_confirmation: 'nogreenthumbs', location: 'Denver County, CO')
user9 = User.create(username: 'Ashley', email: 'amjames.design@gmail.com', password: 'password2', password_confirmation: 'password2', location: 'Jefferson County, CO')
user10 = User.create(username: 'Scott', email: 'scott@turing.edu', password: 'password3', password_confirmation: 'password3', location: 'Denver County, CO')

plant1 = Plant.create(photo: "https://images.pexels.com/photos/1407305/pexels-photo-1407305.jpeg", plant_type: "monstera", indoor: true, user_id: user1.id)
plant2 = Plant.create(photo: "https://images.pexels.com/photos/1084199/pexels-photo-1084199.jpeg", plant_type: "pothos", indoor: true, user_id: user2.id)
plant3 = Plant.create(photo: "https://images.pexels.com/photos/9566463/pexels-photo-9566463.jpeg", plant_type: "philodendron", indoor: true, user_id: user3.id)
plant4 = Plant.create(photo: "https://images.pexels.com/photos/1054019/pexels-photo-1054019.jpeg", plant_type: "honeysuckle", indoor: false, user_id: user4.id)
plant5 = Plant.create(photo: "https://images.pexels.com/photos/6913639/pexels-photo-6913639.jpeg", plant_type: "mother of pearl", indoor: true, user_id: user5.id)
plant6 = Plant.create(photo: "https://images.pexels.com/photos/4750370/pexels-photo-4750370.jpeg", plant_type: "rosemary", indoor: false, user_id: user6.id)
plant7 = Plant.create(photo: "https://images.pexels.com/photos/6231771/pexels-photo-6231771.jpeg", plant_type: "salvia", indoor: false, user_id: user7.id)
plant8 = Plant.create(photo: "https://images.pexels.com/photos/2123482/pexels-photo-2123482.jpeg", plant_type: "snake plant", indoor: true, user_id: user8.id)
plant9 = Plant.create(photo: "https://images.pexels.com/photos/6044736/pexels-photo-6044736.jpeg", plant_type: "fiddle leaf fig", indoor: true, user_id: user9.id)
plant10 = Plant.create(photo: "https://images.pexels.com/photos/7745317/pexels-photo-7745317.jpeg", plant_type: "monstera", indoor: true, user_id: user10.id)
plant11 = Plant.create(photo: "https://images.pexels.com/photos/10891365/pexels-photo-10891365.jpeg", plant_type: "geranium", indoor: false, user_id: user1.id)
plant12 = Plant.create(photo: "https://images.pexels.com/photos/1046490/pexels-photo-1046490.jpeg", plant_type: "giant bird of paradise", indoor: true, user_id: user1.id)
plant13 = Plant.create(photo: "https://sunblestproducts.com/wp-content/uploads/2020/12/dragonblood-tree-seeds-images-www.sunblestproducts.com-2-768x559.jpg", plant_type: "dragon tree", indoor: true, user_id: user2.id)
plant14 = Plant.create(photo: "https://cdn.shortpixel.ai/client/q_lossy,ret_img,w_820/https://www.urbanorganicyield.com/wp-content/uploads/2019/07/Propagating-Ponytail-Palm-pups.jpg", plant_type: "ponytail palm", indoor: true, user_id: user3.id)
plant15 = Plant.create(photo: "https://5.imimg.com/data5/IL/VO/JO/ANDROID-66651570/product-jpeg-250x250.jpg", plant_type: "aloe vera", indoor: false, user_id: user4.id)

listing1 = Listing.create(quantity: 1, category: 'plant', rooted: true, user_id: user1.id, plant_id: plant1.id, description: "A really nice plant", active: true)
listing2 = Listing.create(quantity: 1, category: 'plant', rooted: true, user_id: user2.id, plant_id: plant2.id, description: "A nice plant", active: true)
listing3 = Listing.create(quantity: 3, category: 'plant', rooted: true, user_id: user3.id, plant_id: plant3.id, description: "Some plants", active: true)
listing4 = Listing.create(quantity: 1, category: 'clippings', rooted: true, user_id: user4.id, plant_id: plant4.id, description: "Plant? No, it's a clipping", active: true)
listing5 = Listing.create(quantity: 10, category: 'seeds', rooted: false, user_id: user5.id, plant_id: plant5.id, description: "Mother of Pearl seeds.", active: true)
listing6 = Listing.create(quantity: 4, category: 'clippings', rooted: true, user_id: user6.id, plant_id: plant6.id, description: "Smell it, cook it, whatever.", active: true)
listing7 = Listing.create(quantity: 1, category: 'plant', rooted: true, user_id: user7.id, plant_id: plant7.id, description: "Don't smoke it, seriously.", active: true)
listing8 = Listing.create(quantity: 2, category: 'clippings', rooted: true, user_id: user8.id, plant_id: plant8.id, description: "Super sick clippings", active: false)
listing9 = Listing.create(quantity: 3, category: 'plant', rooted: true, user_id: user8.id, plant_id: plant9.id, description: "Fiddle Leaf Fig, Yo", active: true)
listing10 = Listing.create(quantity: 1, category: 'clippings', rooted: true, user_id: user10.id, plant_id: plant10.id, description: "Clippings, but you can't have them.", active: false)
listing11 = Listing.create(quantity: 2, category: 'plant', rooted: true, user_id: user1.id, plant_id: plant11.id, description: "So stink, so beautiful. Geraniums", active: true)
listing12 = Listing.create(quantity: 1, category: 'clippings', rooted: true, user_id: user1.id, plant_id: plant12.id, description: "Giant BoP clipping", active: true)
listing13 = Listing.create(quantity: 5, category: 'seeds', rooted: false, user_id: user2.id, plant_id: plant13.id, description: "Literally just seeds", active: true)
listing14 = Listing.create(quantity: 1, category: 'clippings', rooted: false, user_id: user3.id, plant_id: plant14.id, description: "Ponytail Palm clippings, hooray!", active: false)
listing15 = Listing.create(quantity: 9, category: 'seeds', rooted: false, user_id: user8.id, plant_id: plant15.id, description: "Healing aloe vera seeds", active: true)