BEGIN TRANSACTION;

DROP TABLE IF EXISTS favorites, brewery_reviews, beer_reviews, beer, brewery, time, users;

CREATE TABLE brewery (
    brewery_id serial NOT NULL,
    brewery_name varchar(64) NOT NULL UNIQUE,
    phone_number varchar(45) NOT NULL,
    address varchar(120) NOT NULL,
	hours text NOT NULL,
    image_url text NOT NULL,
    description text NULL,
	is_approved boolean DEFAULT false,
    owner int NULL,

    CONSTRAINT pk_brewery PRIMARY KEY (brewery_id)
);

CREATE TABLE users (
	user_id SERIAL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

-- CREATE TABLE brewery_reviews (
--     review_id serial NOT NULL,
--     brewery_id int NOT NULL,
--     user_id int NOT NULL,
--     rating int NOT NULL,
--     review varchar(1000) NULL,
--     response varchar(600) NULL,

--     CONSTRAINT pk_brewery_review PRIMARY KEY (review_id),
--     CONSTRAINT fk_brewery_review_brewery_id FOREIGN KEY (brewery_id) REFERENCES brewery (brewery_id),
--     CONSTRAINT fk_brewery_review_user_id FOREIGN KEY (user_id) REFERENCES users (user_id)
-- );

CREATE TABLE favorites (
    brewery_id int NOT NULL,
    user_id int NOT NULL,

    CONSTRAINT pk_favorites_brewery_id_user_id PRIMARY KEY (brewery_id, user_id),
    CONSTRAINT fk_favorites_brewery_id FOREIGN KEY (brewery_id) REFERENCES brewery (brewery_id),
    CONSTRAINT fk_favorites_user_id FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE time (
	brewery_id int NOT NULL,
    day int NULL,
    open_time int NULL,
    close_time int NULL,
    open boolean NOT NULL
);

CREATE TABLE beer (
    beer_id serial NOT NULL,
    brewery_id int NOT NULL,
    name varchar(64) NOT NULL,
    style varchar(64) NULL,
    price money NULL,
    abv float(2) NULL,
    image text NULL,
    description varchar(1000) NULL,

    CONSTRAINT pk_beer PRIMARY KEY (beer_id)
);

CREATE TABLE beer_reviews (
    review_id serial NOT NULL,
    beer_id int NOT NULL,
    user_id int NOT NULL,
	brewery_id int NOT NULL,
    rating int NOT NULL,
    review varchar(600) NULL,

    CONSTRAINT pk_beer_review PRIMARY KEY (review_id),
    CONSTRAINT fk_beer_review_beer_id FOREIGN KEY (beer_id) REFERENCES beer (beer_id),
    CONSTRAINT fk_beer_review_user_id FOREIGN KEY (user_id) REFERENCES users (user_id),
	CONSTRAINT fk_beer_review_brewery_id FOREIGN KEY (brewery_id) REFERENCES brewery (brewery_id)
	
);


INSERT INTO users (username,password_hash,role) VALUES ('PhillyFan4Life','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$10$yM5uZTKxLgY5LQcZzY54DuRSiB7q0amH0r.wMLsbSfWpLn3wh/BGe','ROLE_ADMIN');
INSERT INTO users (username,password_hash,role) VALUES ('RealKevinSmith','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('BeerLover42','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('SopranosFan555','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('brewer','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('MiracleF','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('GianniP','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('KevinSmith','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_BREWER');
INSERT INTO users (username,password_hash,role) VALUES ('ryanm','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_BREWER');




/***********************************************************************************************************
 Populating brewewry table with 8 breweries
***********************************************************************************************************/
INSERT INTO public.brewery(brewery_name, phone_number, address, hours, image_url, description,is_approved, owner) VALUES
	('Second District Brewing', '(215) 575-5900', '1939 S. Bancroft Street Philadelphia, PA 19145', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/7053061e17da04bd978ae77cf085fa9d.jpg',
	'Ben Potts has been brewing in the Philadelphia region for over 14 years, working with some of the areas most well known breweries. With a background focused heavily on experimentation and pushing the boundaries of what we know as ‘beer’, Ben has done it all - from working with exotic fruits and spices, barrel aging, mixed fermentation techniques, to some of the most unconventional brewing ingredients possible. With that in mind, Ben brings all of his experience to Second District, creating both off-the-wall flavors and classically inspired styles, along with everything in between.',true, 7),
	('Crime and Punishment Brewing Company', '(215) 235-2739', '2711 W Girard Ave, Philadelphia, PA 19130', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/fb468bf28e0dcda284e7c7e7adc3095c.jpg',
	'From ales and lagers, to saisons and IPAs, there’s something on tap for everyone. C+P aims to blend the once-great local brewing tradition with newer craft techniques and international inspirations. They have designed a rotating menu of distinctive brews and Russian-influenced dishes done their way. Crime + Punishment is proud to be part of a thriving community. We partner with local organizations to promote the rich culture of Brewerytown. Whether sponsoring the little league or hosting Philly arts events, C+P seeks creative ways to step outside our walls and participate in neighborhood life. It’s not just a place to eat and drink, it’s a place to get to know your neighbors. Great beer.  Great food. Great community. Crime + Punishment welcomes you.',true,7),
	('Yards Brewing Company', '(215) 525-0715', '500 Spring Garden St Philadelphia, PA 19123', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/8c336be5e2177a839bed109d8ba8a193.png',
	'Yards has been brewing Philly''s beer since 1994. We’ve grown from a garage-sized operation in Manayunk all the way up to our current location at 500 Spring Garden Street in Northern Liberties. And we couldn''t have done it without your support through the years. Our beers always have and always will be brewed, bottled, kegged, and canned for the hard working people of Philadelphia and beyond.',true, 7),
	('Love City Brewing', '(215) 398-1900', '1023 Hamiltion Street Philadelphia, PA 19123', 'M-F: 8-11 S-S: 8-2', 'https://i.gyazo.com/b88a2a13dedf6a003f4ebf7f6c2bacad.png',
	'We create unfailingly delicious beer that is the centerpiece of Philadelphia’s table. We do whatever it takes to ensure the quality of each beer we serve. At Love City, we take care of each other. We prioritize relationships with our customers, colleagues, and community. We grow at a pace that allows us to maintain these values and priorities. We work hard to demonstrate what a craft brewery should be – a responsible small business that makes outstanding beer while respecting the people that make it possible.',true,7),
	('2nd Story Brewing Co.', '(267) 314-5770', '117 Chestnut St, Philadelphia, PA 19106', 'M-F: 7-12 S-S: 8-2', 'https://eventective-media.azureedge.net/3099496_lg.jpg',
	'We all have a first story. It’s the one we tell to strangers, job interviewers and people we meet during the course of a day. It’s who we are, where we’re from, what we do, people we know. But our second story is all about the passion we have deep inside. It’s the things we love to do because it defines who we are. At 2nd Story Brewing Co., our passion is the craft beer that you can witness for yourself being brewed on the second floor. It’s where our second story comes together. It’s where our stellar beer is hand-crafted and handed down.','true', 10),
	('Mainstay Independent Brewing Company', '(215) 422-3561', ' 901 N Delaware Ave, Philadelphia, PA 19123', 'M-F: 4-12 S-S: 8-2', 'https://mainstaybrewing.com/images/beerlist_breaker.jpg','Craft Hall is Philadelphia’s largest beer hal where you’ll enjoy Mainstay Independent’s delicious brews in a creative, family-friendly atmosphere.This lively space for aficionados of artisanal foods and craft beer connoisseurs includes a large scale open gourmet kitchen provisioned by Lost Bread Company, a fully operational independent bakery operation serving Craft Hall and the region. The space features two full bars and multiple seating areas—from quiet lounges to lively group settings—a playground for kids and adults alike, a live music stage showcasing rotating talent and more than you can absorb in a single visit. Craft Hall is a dining and drinking experience truly born, brewed and crafted in Philly! ',true, 10),
	('Philadelphia Brewing Co.', '(215) 427-2739', '2440 Frankford Ave, Philadelphia, PA 19125', 'M-F: 8-11 S-S: 8-2', 'https://guidetophilly.com/wp-content/uploads/Philadelphia-Brewing-Co-exterior-1.jpg','Decades of brewing experience and an unwavering passion for the science of brewing are what define us best. We skillfully create our recipes by using only the best ingredients available. By adapting old world beer styles with modern brewing techniques, we have developed unique flavors that represent Philadelphia proudly. With more than a dozen different styles of ales and lagers brewed annually we have a beer for every discerning palate.',true, 10),
	('Victory Brewing Company Philadelphia', '(445) 223-1130', '1776 Benjamin Franklin Pkwy, Philadelphia, PA 19103', 'M-F: 11-11 S-S: 11-10', 'https://victorybeer.com/wp-content/uploads/2022/03/Victory-Brewing-Company.png','We pour a full lineup of Victory beers and seltzers in addition to beer and cider from our sister brands Southern Tier Brewing Company, Sixpoint Brewing Company, and Bold Rock Hard Cider, plus spirits from Southern Tier Distilling Company. We also offer a wide selection of packaged beer and spirits to go!',true, 10),
	('Triple Bottom Brewing', '(267) 764-1994', '915 Spring Garden St, Philadelphia, PA 19123', 'M-F: 12-7 S-S: 12-10', 'https://images.squarespace-cdn.com/content/v1/57d21485197aea6d03f1c001/1609256061933-7BLMDSYFP9GUQA3OKERA/brewery+%2B+taproom?format=1000w','Triple Bottom Brewing is a craft brewery with a social mission in Philadelphia, Pennsylvania. We celebrate community through delicious beer and creative collaboration. As a fair chance brewery, we create meaningful, living-wage jobs for people who have experienced homelessness or incarceration, and may otherwise be excluded from the mainstream economy. We’re a certified B Corp, and we believe everyone in every community should have the opportunity to craft something great. Come say hello next time you’re in the neighborhood! ',true, 10),
	('Brewery ARS', '(215) 960-5173', '1927 W Passyunk Ave Philadelphia, PA 19145', 'M-F: 4-12 S-S: 12-12', 'https://dixon.philly.com/wp-content/uploads/2017/08/752417_4f44a672fb8b66f.jpg','A SOUTH PHILLY GARAGE BREWERY',true, 10),
	('Urban Village Brewing Company', '(267) 687-1961', '1001 N 2nd St, Philadelphia, PA 19123', 'M-F: 12-11 S-S: 12-12', 'https://i0.wp.com/beerbusterspodcast.com/wp-content/uploads/2017/06/interior-1-2.jpg?ssl=1','Urban Village is all about supporting the local community and creating value for the locals as the heart of a growing Philadelphia and northern liberties community. We were very proud to collaborate with them to show that sense of community. We are only as strong as each other.',true, 10),
	('Dock Street Brewery South', '(215) 337-3103', '2118 Washington Ave, Philadelphia, PA 19146', 'M-F: 11-10 S-S: 11-11', 'https://images.squarespace-cdn.com/content/v1/55c8df6be4b051f0536b7701/1439314441907-D4IQ698DE1O2BCJBOSX3/image-asset.png','Welcome to Dock Street South, the newest location of Philadelphia’s First Craft Brewing Co. Our Point Breeze location serves Lunch, Dinner and Weekend Brunch. Enjoy our menu of hand-tossed, wood-fired pizzas, brasserie-inspired sandwiches, salads and noms that stand on their own and also pair beautifully with great beer and cocktails. Think: classic and creative pizzas, craveable and shareable plates like our Whipped Ricotta, Mac + Cheese, and an incredible Smash Burger, and inventive, fresh salads, to name a few. Stay in the comfort of your own home and enjoy  locally brewed craft beer and delicious food by ordering online today!',true, 10),
	('Attic Brewing Company', '(267) 748-2495', '137 Berkley St, Philadelphia, PA 19144', 'M-F: 4-11 S-S: 3-12', 'https://phillyofficeretail.com/wp-content/uploads/2020/04/Attic-for-web1.jpg','Come spend some time with us in the historic Germantown neighborhood of Philadelphia!  We have 14 of our very own, award winning craft beers on tap, along with wine, cider, cocktail, and spirit options. Visit our taproom located in what used to be the historic Blaisdell Pencil factory, or hang out in our huge beer garden behind the taproom.  Food trucks rotate through on a daily basis, and we host live music, comedy, and vinyl DJ.s throughout the week!',true, 10),
	('Wissahickon Brewing Company', '(215) 483-8833', '3705 W School House Ln, Philadelphia, PA 19129', 'M-F: 4-11 S-S: 8-10', 'https://www.wissahickonbrew.com/wp-content/uploads/2021/11/wissahickon-merch-2.jpg','Wissahickon Brewing Company is a family owned & operated brewery located in East Falls, Philadelphia, PA. The story begins with a dad and his sons and daughter homebrewing in their mother’s kitchen. After years of recipe formulation, education, and a lot of hard work and ambition, the Gill family fulfilled their dream and officially opened the doors of Wissahickon Brewing Company in their hometown of Philadelphia. After opening in 2017, the brewery has since grown tremendously. Wissahickon attributes its growth to brewing premium quality beer, staying involved within the local community, and challenging the status quo. Come join the family and experience what Wissahickon has to offer!',true, 10),
	('Cartesian Brewing', '(215) 543-6000', '1326 E Passyunk Ave, Philadelphia, PA 19147', 'M-F: 3-12 S-S: 3-10', 'https://philadelphiaweekly.com/wp-content/uploads/2022/01/image_64834414-1024x768.jpg','We believe in farm-to-table, grower-to-glass, producer-to-pint. That''s why we started Cartesian Brewing. When you drink a glass of our beer or fill a growler of our cider, you won''t just know the ABVs and IBUs, you''ll know the name of the people who malted the grains, who grew the hops, who picked the apples, who opened the tap. Local Origin Ales and Ciders.',true, 10),
	('Source Urban Brewery', '(267) 519-3237', '1101 Frankford Ave, Philadelphia, PA 19125', 'M-F:28-11 S-S: 8-12', 'https://resizer.otstatic.com/v2/photos/xlarge/2/47224574.jpg','Family and balance is a focus at the Source. Our first floor taproom welcomes families with kids, second floor mezzanine and rooftop terrace is reserved for adults only and our biergarten and grounds are open to all to enjoy, including dogs.',true, 10),
	('Other Half Brewing', '(215) 497-0640', '1002 Canal St, Philadelphia, PA 19123', 'M-F: 10-11 S-S: 2-10', 'https://media.bizj.us/view/img/12200954/img2168*750xx4032-2268-0-378.jpg','Sam Richardson, Matt Monahan, and Andrew Burman founded Other Half Brewing Company in Brooklyn, NY in 2014 with a simple mission: to create beer that they wanted to drink from a company that they wanted to be a part of. Their vision was to push the boundaries of beer and the culture that surrounds it by representing the “Other Half” of the industry.',true, 10),
	('Chestnut Hill Brewing Company', '(215) 247-0330', '8221 Germantown Ave, Philadelphia, PA 19118', 'M-F: 11-9 S-S: 4-9', 'https://www.chestnuthillbrewingcompany.com/wp-content/uploads/2022/08/bar-1.jpg','We decided to tweak that model and offer beer, brewed on site, along with Neapolitan, wood-fired pizza. Our founding mascot, Newfoundland, Ralph, was a large part of our life and is also the company mascot. Since his passing in March of 2018, Barley and Hopz have joined our family and Chestnut Hill Brewing Company as the second generation mascots and heirs to the throne.',true, 10),
	('Iron Hill Brewery & Restaurant', '(267) 507-7365', '1150 Market St, Philadelphia, PA 19107', 'M-F: 11-12 S-S: 11-11', 'https://www.ironhillbrewery.com/assets/craft/_locationPic1x/CC-Exterior.jpg','NOTHING’S TRUER TO WHO WE ARE than letting our craft beers and handcrafted foods inspire one another in unexpected ways. And while we’re themost award-winning breweryeast of the Mississippi,we’re not in it for the fame or the glory.We’re in it because we love what we do.Which is brewing beer.Getting creative in the kitchen.And integrating our passion from tap to table.We’re more than a scratch kitchen.We’re more than a craft brewery.We’re CRAFT KITCHEN. SCRATCH BREWERY.Local Brewers. Award-winning Beer. WELCOME.',true, 10),
	('Twisted Gingers Brewing Co', '(267) 766-6614', '4317 Fleming St, Philadelphia, PA 19128', 'M-F: 4-10 S-S: 4-9', 'https://s3-media0.fl.yelpcdn.com/bphoto/YU6fUg9d6RzK7xJ7T5U93A/l.jpg','Twisted Gingers Brewing Company is a neighborhood taproom and Artisan Pizza Kitchen powered by passion for doing great things in life and taking a moment to celebrate them!  Our 101 year old taproom is nestled in the hills of Manayunk halfway between Ridge Pike and Main Street Manayunk. Progressing the 1918 tavern legacy, the purpose is simple: Offer a fun craft beer experience with the freshest beer and pizza.  Rotating 8 beers brewed onsite weekly plus hard seltzers & ciders, canned cocktails and sparkling spring waters there is something for everyone to enjoy. Our philosophy is to “Celebrate Life with a Twist”. The ‘twist’ is all about finding the positives in your day to continue moving forward in life! No matter how simple or sarcastic it’s what makes your glass always full here!',true, 10),
	('Humble Parlor Brewing Company', '(610) 442-8135', '3237 Amber St Unit 4-2-E, Philadelphia, PA 19134', 'W-T: 5-8 S-S: 2-7', 'https://breweriesinpa.com/wp-content/uploads/2021/11/IMG_0913.jpg','We are opening in a former textile mill from the 1920s. It was bought and repurposed into smaller units, and we are right near many other businesses including manufacturing, artists, and also Sacred Vice Brewing! Out location is about 600 sq/ft and will have about a 14 ft bar with 4-8 taps, and 7 seats. We will have a couch/living room area, and the max occupancy will probably be around 25. There is a sectioned-off space for the brewery, that will be pretty visible for customers. We currently have a half BBL system with a few fermenters and looking to add more very soon. I will be doing split batches when I brew.',true, 10),
	('Barrel Splitters Brewing', '(215) 941-6228', '1890 Woodhaven Rd, Philadelphia, PA 19116', 'M-F: 2-10 S-S: 12-10', 'https://assets.untappd.com/photos/2021_08_27/fb91b1bfa2fb6c2278b17ffb36ef146d_640x640.jpg','We are a local family-owned taproom and hangout for anyone that needs a break from their day. We offer a relaxed environment with exceptional craft beers to enjoy with friends, family, service members, and coworkers.',true, 10),
	('Lucky Cat Brewing Company', '215) 856-3591', '6235 Frankford Ave, Philadelphia, PA 19135', 'M-F: 8-11 S-S: 8-2', 'http://luckycatbrewing.com/pix/dusty2.jpg','Lucky Cat Beer is a nano brewery operated by Mike "Scoats" Scotese and Jason Macias. Due to rapidly changing times, we had to radically change course multiple times over our 3 years of existence. We learned to be nimble and patient. And it got us to where we are now.We have teamed up with Broken Goblet and Trauger Brewering to found Mutual Respect Brewers Co-op in Bensalem, PA. Mutual Respect is housed in Broken Goblets space on State Road, expanding into an additional 6,000 square feet there.Besides brewing whatever strikes our fancy, our focus is on recreating craft beers that have been lost to time for whatever reason. Lucky Cat Beer is the evolution of The Grey Lodge Pub, one of Philadelphias original beer bars.',true, 10),
	('New Ridge Brewing Co.', '(215) 330-4677', '6168 Ridge Ave, Philadelphia, PA 19128', 'M-F: 8-11 S-S: 8-2', 'https://cdn.nerdydeeds.dev/portfolio/199A3876.jpg','New Ridge Brewing Co. is a full-scale brewery and restaurant located in the heart of “The Ridge” in Northwest Philadelphia’s Roxborough neighborhood. Our beers are made on site on our 7 barrel brew house, using the highest quality American and European ingredients. We offer a seasonally rotating food menu featuring local and sustainable vendors, along with a curated cocktail and wine list made up of Pennsylvania wineries and distilleries.',true, 10),
	('Human Robot', '(215) 978-4000', '1710 N. 5th St Philadelphia, Pennsylvania 19122', 'M-F: 11-11 S-S: 5-9', 'https://arc-anglerfish-arc2-prod-pmn.s3.amazonaws.com/public/4OPFHHUJJ5CY3GDCVJ7PIH5XAA.jpg','Human Robot Beer is very chill, not intimidating, and is a place for beer drinking perfectly executed, no nonsense beer. We often talk about craft lager rising in popularity in the vast sea of IPA. With the type of formula Human Robot Beer is using to fill a much needed void, I can see this being part of a turning point in current craft beer culture. There was no aspect of hype culture, ticking culture, collecting culture, hoarding culture as far as I could tell, and that made for a very enjoyable to day visit.',true, 10),
	('Fermentery Form', 'bottles@fermenteryform.com', '1700 N. Palethorp St., Philadelphia, PA, United States, Pennsylvania', 'M-F: 12-11 S-S: 7-2', 'https://dixon.philly.com/wp-content/uploads/2018/01/1005733_65b9a0dfbcca668.jpg','We are a small artisan brewery in West Kensington, Philadelphia. We produce delicate and flavorful beers, fermented with our own mixed cultures. A central pillar of our production is our Solera system. This pyramid of barrels contains beer of various ages, in an array of oak types from around the world. This allows us a broad palette for blending beers to our unique taste. Please enjoy them with us.',true, 10),
	('Punch Buggy Brewing Company', 'punchbuggybrewingcompany.com', '1445 N American St, Philadelphia, PA 19122', 'M-F: 12-8 S-S: 12-8', 'https://i.gyazo.com/cb81f2e37fa599a5c693811d468ea9b9.png','Small-batch Philadelphia-based nanobrewery.',true, 10),
	('Separatist South Philly', '(267) 534-4879', '1646 S 12th St, Philadelphia, PA 19147', 'M-F: 4-11 S-S: 12-12', 'https://www.inquirer.com/resizer/SbQjVPw_EhpxbzAC9IU1sLc4CI8=/760x507/smart/filters:format(webp)/arc-anglerfish-arc2-prod-pmn.s3.amazonaws.com/public/NL76OKCBSRD3NLMEE26YPIFD44.jpg','If you ask us what we are all about at Separatist Beer Project, the answer is simple: Hops, Lagerbier and Spontaneous Fermentation. From our classic, easy-drinking quintessential Cream Ale to our Wild Ale Blendery series we aim to create the best beer possible. While we brew a large variety of hoppy IPAs and crisp Lagers, our true passion can be found within the Blendery—a space we have dedicated to rustic brewing. Here amongst the barrels you can find us working on an array of spontaneously fermented ales based on the traditional methods we learned while studying in Europe. With the recent addition of a Koelschip, our Blendery has become our sanctuary to the art of brewing.',true, 10),
	('Evil Genius Beer Company', '(215) 425-6820', '1727 N Front St, Philadelphia, PA 19122', 'M-F: 12-8 S-S: 12-8', 'https://media.timeout.com/images/104011097/image.jpg','VERY SILLY NAMES FOR VERY SERIOUS BEERS. Beer – it’s why we’re all here. Check out what’s available year-round, seasonally & at The Lab.',true, 10),
	('Liquid Art Barrel House', '(215) 995-6792', '990 Spring Garden St, Philadelphia, PA 19123', 'M-F: 1-10 S-S: 1-8', 'https://images.squarespace-cdn.com/content/v1/57c5ee5220099e12c27b69c3/1496177786942-1DH024Z10IW0F7Z10IXW/RoyPitz_990__31.JPG','The Liquid Art Barrel House is a Philadelphia brewpub from the Liquid Art Brewing Company. Built and designed to reflect and showcase the artistry and craftsman behind the beer, food and the space itself. The Barrel House is fitting in the industrial style of the building, built directly into the old truck docks and is the newest fixture in the developing Spring Arts neighborhood. The bar features the full portfolio of award winning beer in addition to some location specific sour, funk and barrel aged Liquid Art specialties along with Pennsylvania craft spirits and wine. The menu at the Barrel House continues the tradition of local and farm fresh ingredients paired alongside the Liquid Art.',true, 10),
	('Sacred Vice Brewing Company', '(215) 690-1686', '3233 Amber St, Philadelphia, PA 19134', 'M-F: Closed S-S: 12-6', 'https://arc-anglerfish-arc2-prod-pmn.s3.amazonaws.com/public/MWXG5IMMCBEAPJ4TSOQAKJX35I.jpg','Artisan brewery located at 3233 Amber St., somewhere between Kensington and Port Richmond. We offer handcrafted beers to go through contactless pickup.',true, 10),
	('Meyers Brewing Company', '(267) 928-3620', '436 E Girard Ave, Philadelphia, PA 19125', 'M-F: 5-11 S-S: 12-12', 'https://breweriesinpa.com/wp-content/uploads/2021/07/img_6682.jpg','Nano brewery in the Fishtown section of Philadelphia.',true, 10),
	('Manayunk Brewing Company', '(215) 482-8220', '4120 Main St, Philadelphia, PA 19127', 'M-F: 12-12 S-S: 12-9', 'https://breweriesinpa.com/wp-content/uploads/2022/02/Manayunk-Brewing.jpg','Manayunk Brewing Company was founded by Harry Renner IV. We tapped our first batch on October 17, 1996. Over the past two decades, and several devastating floods, Manayunk has become considered by many to be one of Philadelphia''s premier breweries. Today we feature not only our staple year round beers, but also limited specialty products both on draft and in 22 ounce bottles. In 2014, the entire brewery was renovated so we could install a new state-of-the-art brew house, outdoor fermenters, more bright tanks and a top of the line glycol cooling system - nearly doubling our brewing capacity. We also began canning several brands, which can be found throughout PA and NJ at your favorite craft beer retail stores. Additionally, you can always find some of our most popular beers at our brewpub on Main Street in Manayunk.',true, 6),
	('Bar Hygge', '(215) 765-2274', '1720 Fairmount Ave, Philadelphia, PA 19130', 'M-F: 4-10 S-S: Closed', 'https://scontent-mia3-2.xx.fbcdn.net/v/t39.30808-6/298494403_469750481825587_8156928750283906873_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=e3f864&_nc_ohc=IgNp9CElwUwAX_dwZ2M&_nc_ht=scontent-mia3-2.xx&oh=00_AfCIJElbQ1kax9L27LCI3U7JVaJNaTcEzcQan15Sp4mKNQ&oe=639E3523','Hygge is a Danish concept, embodying a feeling or mood, that comes from taking genuine pleasure in making ordinary, every day things more meaningful, beautiful or special. For us at Bar Hygge, it means creating a warm atmosphere where guests can enjoy the good things in life with friends and family.',true, 6),
	('Tired Hands Brewing Company', '(484) 413-2983', '35 Cricket Terrace, Ardmore, PA 19003', 'M-F: 12-9 S-S: 12-9', 'https://breweriesinpa.com/wp-content/uploads/2022/05/tired-hands-fermentaria-940.jpeg','Tired Hands Brewing Company was born in the confines of Jean’s parent’s garage over eight years ago. He began brewing beer partly out of intrigue, but entirely out of passion. During his college years, his father had turned him on to the hoppy pale ales and IPAs of the West Coast, which eventually led to many months of beer exploration. During this time, he discovered the beautifully dry and expressive farmhouse ales of France and Belgium. After a few months of homebrewing, Jean entered his beer into a local homebrew competition (now one of the nation’s largest), and took first place in the Belgian category with his Saison. Upon obtaining a degree in Special Education (a skill set that has been instrumental throughout his brewing career!) from West Chester University, Jean set off to pursue his passion for beer professionally. He landed a job at Weyerbacher Brewing Company in Easton, Pennsylvania. Through Weyerbacher, Jean learned the ins and outs of brewery management (filtration, bottling, kegging, scrubbing mold, etc.) and made many great friends in the process.  After some time at Weyerbacher, Jean moved on to Iron Hill, where he worked as a brewer at their West Chester location for nearly five years. During this time Jean fell head-over-heels in love with the brewpub model of brewing. By creating beer in one room, and then serving it in another, he was able to connect to the people drinking his beer on a personal level daily; a perk previously unavailable to him while working in a production brewery. After many years of brewing professionally in different environments, much travel, careful consideration, and quite a few business classes from both Wharton and the Community College of Philadelphia, Jean built Tired Hands Brewing Company to be a concise rendition of his ideal brewing environment.',true, 6),
	('Fat Lady Brewing', '(267) 748-2282', '4323 Main St, Philadelphia, PA 19127', 'M-F: 4-10 S-S: 1-8', 'https://www.pabrewreview.com/images/breweries/755/slideshow/1%20taproom.jpg','On top of our extensive selection of in-house brews, we proudly collaborate with our local family of craft brewers to serve you the best of PA, no matter who brewed it.',true, 6),
	('Glory Beer Bar and Kitchen', '(267) 687-7878', '126 Chestnut St, Philadelphia, PA 19106', 'M-F: 12-12 S-S: 12-2', 'https://gloryphilly.com/mainm.jpg','Dave, a long time Philadelphia resident, has spent 15 years behind the bar, the last 10, of course, being the stalwart beer aficionado at the old Eulogy Belgian Tavern. Dave prides himself on not just having a vast knowledge of product but an acumen that delivers on that knowledge and gives each guest their own personalized , optimal exerience. From bartending, bar ownership always seemed to be his natural progression. He credits this opportunity to all the good people he has met along the way that helped lay the road that he now sets out upon.',true, 6),
	('Cheshire Brewing Co', '(215) 277-1729', '7909 High School Rd Vendor 1, Elkins Park, PA 19027', 'M-F: 11-12 S-S: 11-9', 'https://breweriesinpa.com/wp-content/uploads/2021/03/img_2838-1068x559.jpg','Cheshire Brewing Co. specializes in brewing the finest craft beers in the country. For carryout or c',true, 6),
	('Moss Mill Brewing Company', '(215) 876-6305', '109 Pike Cir unit d, Huntingdon Valley, PA 19006', 'M-F: 12-10 S-S: 1-7', 'https://assets.simpleviewinc.com/simpleview/image/upload/crm/bucks/Moss-Mill-Brewing-15-1--9306e0ef5056a36_9306e567-5056-a36a-0b193a1d41b19fd7.jpg','Moss Mill Brewing is a nano brewery with three rooms: brew-house, lab/office, and tap room. Here you will find a rustic industrial vibe that is warm and welcoming.',true, 6),
	('Broken Goblet Brewing', '(267) 812-5653', '2500 State Rd. Unit D, Bensalem Township, PA 19020', 'M-F: 5-11 S-S: 11-5', 'https://static.wixstatic.com/media/7a207d_0189990fc0544868bedd2dbf75e69597~mv2.jpg/v1/fill/w_2500,h_1666,al_c/7a207d_0189990fc0544868bedd2dbf75e69597~mv2.jpg','Broken Goblet Brewing didn’t start as a paradigm-shifting microbrewery. It didn’t even start as Broken Goblet. It started as Brewtal Beer….. The Brewtal Beer Club, in fact. Co-owners Mike Lock and Jay Grosse, while lamenting their jobs and drinking some quality beer, concocted a plan to do something that they enjoyed and maybe even make a living of it. They formulated the brand, invented a very handsome mascot, and approached it from a very different angle – form a club that could grow into a fertile testing ground for ideas, marketing plans and beer testers. With the help of 12 other “founders”, the club was formed and grew from 13-30 in just 6 months, with special events pushing 100+ guests. Out of the group, two brewers stepped forward, similar in vision and equally ready to try something new. And so, Mike and Jay, together with the new brew guys Bub Grosse and Bitter Joe Fazekas, began the very expensive process to bring Brewtal beer from a club to a full-fledged brewery......then came the lawyers.',true, 6),
	('Naked Brewing Company', '(215) 322-1279', '51 Buck Rd, Huntingdon Valley, PA 19006', 'M-F: Closed S-S: 1-9', 'https://i.gyazo.com/9ce2d0ef1f1b43b128d86800c6400334.png','I got bit by the brewing bug in college in the early nineties. Back before the internet, armed with my copy of The Joy of Homebrewing and a local homebrew shop, I started creating beers for my friends and myself that would compete with “The Beast”. My early influences were breweries like Sierra Nevada and Anchor Steam, as well as local breweries Nodding Head and Dock Street. Being a social brewer I have enjoyed making beers with many different friends over the years, but it was always a hobby. That changed when Brian and I started brewing together in 2009. We decided to take it to the next level, and with input from the many great home brewers from Ale-iens Home Brew Club and The Hulmeville Inn, we refined our beers and debuted them at the Newtown Beer Fest in 2011. The positive response gave us more confidence and we decided to go for it. We were licensed in Brian’s garage on April Fool’s Day 2012, and within a few months we moved to our present location here on Buck Rd in Lower Southampton Township',true, 6),
	('Double Nickel Brewing Company', '(856) 356-2499', '1585 NJ-73, Pennsauken Township, NJ 08110', 'M-F: 4-10 S-S: 4-10', 'https://www.cheerssj.com/wp-content/uploads/2022/03/AY0I1265_57b755e1aa025f113585723166409f90-scaled-1.jpg','Our brewing philosophy is simple on the surface but goes layers deep. At its most basic it’s all about making approachable balanced beers that bring people together and help create lasting memories. At the end of the day there should always be something for everyone.  If you look deeper, while each brew is grounded in tradition and draws inspiration from the past, we also strive for the finished product to evoke a modern take rich in innovation and creativity without being pretentious.',true, 6)



;


/***********************************************************************************************************
 Populating beer
***********************************************************************************************************/
INSERT INTO public.beer(brewery_id, name, style, price, abv, image, description) VALUES
	(1, 'Bancroft Beer', 'Ale', 6, 4.20, 'https://i.gyazo.com/666f5ded17e8474d2f1be8f99177e91e.png', 'Our daily drinker, named after the street our humble brewery rests on. Brewed with American 2-row and English Maris Otter malt. Singularly hopped with Mosaic. Punchy notes of Satsuma orange rind, lychee flesh, and fresh blueberry muffin with a clean and crisp finish. 4.20% abv'),
	(1, 'Smoked Dunkel', 'Lager', 8, 6, 'https://i.gyazo.com/5ab93c917140b256ba4ca19ab706420a.png', 'Take a jaunt north from Munich to Bamberg with this smoky brown lager. Traditional Munich Dunkel grist with a slightly northern spin combining two of our favorite styles – Munich Dunkel and Bamberg Rauchbier. Brewed with German Pilsner, Munich, and a modest percentage of beechwood smoked malts and a dash of Spalt Select hops. Rich flavors of hearth baked bread smothered in Nutella with a sprinkle of toffee and fire roasted smores. A real Fall treat. 5.5%abv'),
    (1, 'Northeast Extension ’22', 'Malt', 5, 4.5, 'https://i.gyazo.com/cf1ee5040dc5496f1e66abdf26be10dd.png', 'Hoppy American Pils. For this year’s batch of Northeast Extension, an annual exploration of PA grown malt and Estate Grown hops from our own Second District Brew Farm, we utilized a simple base of Colonial Pilsner malt from our friends at Deer Creek and then dressed it up with Brew Farm Cascade and Willamette. We then fermented the resulting wort with our house lager yeast to create a zippy unfiltered pilsner jam-packed with Pennsylvania terroir. Clean crackery malt notes followed by grassy green tea with a hint of orange peel. 4.5% abv'),
    (1, 'Chadwick on Brett', 'Brown Ale', 6, 8, 'https://gyazo.com/933d612124705843ead259c794d20106.png', 'We took a small portion of the original late-Spring batch of Chadwick before carbonation, spiked it with a bit of brett, and let it condition for the Summer. The result is a delicious introspective into what porter might have been like after traveling in oak barrels for long periods of time back in the 1800’s. More dry than the fresh version, woody, bittersweet cacao, gentle twang with a little mystery. *NITRO*'),
    (1, 'Pils Mercato', 'Pilsner', 5, 5.2, 'https://i.gyazo.com/65ab0eb5a2e35969ccfc45f0ae0ac419.png', 'Created with our friends at DiBruno’s as a nod to their history and heritage and the original Italian Market storefront on 9th street. Brewed entirely with lovely German pilsner malt, we then took local Viva Leaf Tea tulsi basil infused honey and added it in the whirlpool to retain as much nuance as possible. Hopped in the kettle with fresh Spalter Select and Hallertauer Mittelfrüher, and then again post fermentation for that modern classic Italian pils profile. Aromas jump out of the glass with honey drizzled bread crust, rolling grassy fields, and gentle black currant. The flavor rides those same waves with a delightfully dry spicy finish. 5.2% abv'),
    (1, 'Entwife', 'Rye Dark Mild', 7, 3.4, 'https://i.gyazo.com/b4109bf6e895e5fc1c3f08134f273474.png', 'Entwife season is here! This beer has a special place in our hearts as one of the first we made for our opening in 2017. Entwife is a Rye Dark Mild built with English Maris Otter, Rye, and Chocolate malts. This year we added English crystal rye as well. Hopped delicately with East Kent Goldings in the kettle. Pint fulls of chocolate Rice Krispies and rich toffee with chewy pumpernickel followed by a spicy finish from the rye. At 3.4%, it’s the perfect beer to accompany a night full of good food and great company.'),
    (2, 'BEHEMOTH', 'Oatmeal Stout', 4, 6.5, 'https://i.gyazo.com/e79924b244c37c84204705bd0f1cc2a0.png', 'Behemoth, our Oatmeal Stout is now on tap! This inky brew''s namesake is an enourmous, demonic, and mischievous black cat from Mikhail Bulgakov''s Novel The Master and Margarita'),
    (2, 'Space Race', 'IPA', 5, 7, 'https://i.gyazo.com/a89c18a03a457b0567047ff78e4db932.png', 'In the world of IPAs, the sky''s the limit. Hopped and dryhopped with Citra, Mosaic, Columbus, and Simcoe. Scents of stone fruits, papaya, and wheat grass commingle with flavors of passionfruit, mango, and grapefruit rind, ultimately leading to a clean, dry finish. Join us on the IPA journey'),
    (2, 'Pig''s Ear', 'Ordinary Bitter', 3, 4.6, 'https://i.gyazo.com/c0b0c7d81c4be21f85fa908c8b6f0539.png', 'Cockney slang for beer! Notes of bran flakes, sourdough bread, plum and raisin. Give us an oxford scholar, take the apples and pears, and try not to spill it on your uncle Bert.'),
    (2, 'Lunokhod', 'IPA', 4, 6, 'https://i.gyazo.com/7a5d893490850846e61c4deb66a04b1c.png', 'Another addition to our family of hoppy beers brewed with barley and hooped with Galaxy and Citra. Lunokhod strikes the perfect balcance of body, hop saturation, and drinkability with notes of ripe mango, melon and ripped green bell peppers.'),
    (3, 'Level Up', 'Tropical IPA', 4, 6.5, 'https://cdn.shopify.com/s/files/1/0405/4247/0302/files/PS_01Can_12oz_front_LevelUp_Yards_shopify-2021.png?v=1626360378', 'This isn’t just any old IPA. It’s a legit India Pale Ale with some serious tropical infusion. So drop in a coin and press play. This is some next level stuff, right here.'),
    (3, 'Star Jockey', 'Galaxy Hop Hazy IPA', 5, 7.2, 'https://cdn.shopify.com/s/files/1/0405/4247/0302/files/PS_01Can_12oz_front_StarJockey_Yards.png?v=1645811469', 'Brewed with Cosmic Punch™ and infused with Galaxy hops, this rocket is ready to ride, buckaroo. So saddle up and hold fast! We don''t blast off, we blast ON! And ON! And ON! Across the universe and beyond.'),
    (3, 'VERY MEGA', 'SUPER DELUXE MEGA AWESOME BEER', 5, 9.2, 'https://cdn.shopify.com/s/files/1/0405/4247/0302/files/PS_01Can_12oz_front_VeryMega_Yards-Shopify.png?v=1664550355', 'ENTERING THE RING WEIGHING IN AT 9.2%, THE 2X IPA CHAMPION OF THE MEGAVERSE, VEEERRRYYY MEGA! SWOLE WITH MEGA TROPICAL NOTES! MEGA CITRUS NOTES! VERY MEGA WILL PILEDRIVE YOUR TASTE BUDDIES WITH MEGA HOP AROMAS AND FLAVOR! QUAFF HARD, PEOPLE!'),
    (3, 'Philly Standard', 'Beer', 4, 4.5, 'https://cdn.shopify.com/s/files/1/0405/4247/0302/files/PS_01Can_12oz_front_PhillyStandard_Yards_shopify-2021.png?v=1626360378', 'Sometimes you just want a beer. No bells. No whistles. Just a good, handcrafted, no-nonsense beer that works just as hard as you do. Light. Clean. Easy. The standard beer for every occasion.'),
    (4, 'Lime City Lager', 'Lime-infused Lager', 6, 4, 'https://scontent-mia3-1.xx.fbcdn.net/v/t39.30808-6/277168343_3587052554854557_3126678053493744048_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=2c4854&_nc_ohc=DXOAWk8rpigAX8DRMFt&_nc_ht=scontent-mia3-1.xx&oh=00_AfDF8bsRo6DLQLjNB25FjzNVE6i2lwly25xPfoyv9LZBNA&oe=639A2BC0', 'That feeling you get when surrounded by good friends & sunshine! Made with lime and sea salt for a bright, refreshing taste. The perfect beer for warm weather & good times.'),
    (4, 'Sure Shot', 'Kölsch', 7, 4.4, 'https://d2j6dbq0eux0bg.cloudfront.net/images/12606017/2942890261.jpg', 'The ultimate session beer! Refreshing and light-bodied, our Kölsch is balanced with pilsner malt and features subtle fruit and spice character.'),
    (4, 'Solid State', 'Helles Lager', 7, 5, 'https://pbs.twimg.com/media/FhTGpVtWIAMm7v5?format=jpg&name=4096x4096', 'Solid State is a Munich-style Helles brewed with German malt and hops. Lightly bready with subtle floral, herbal hop character and a crisp finish. The beer to reach for after a long day'),
    (4, 'Unity', 'American IPA', 7, 5.5, 'https://products3.imgix.drizly.com/ci-love-city-unity-ipa-1bdae5d9c48a64f3.png?auto=format%2Ccompress&ch=Width%2CDPR&fm=jpg&q=20', 'This approachable IPA brings hop lovers together around the citrus flavors of our hop blend. It is assertive, yet highly drinkable. Low bitterness and a crisp finish.'),
    (5, 'Declaration IPA', 'American IPA', 6, 6.5, 'https://i.gyazo.com/0968f45c3d2976510ecec0d379045285.png', 'Warrior, Chinook, Centennial, Amarillo and Simcoe. Cheers to life, liberty and the pursuit of hoppiness!'),
    (5, 'Amarillo Sky', 'Pilsner', 3, 5.5, 'https://i.gyazo.com/684737b315bef0d99f1bcdf1889d3827.png', 'A crisp, crushable homage to all that take the tractor another round. Classic pilsner bit with a light lemon back and toasted cracker finish.'),
    (5, 'Brighter Dayz', 'Hazy IPA', 5, 8.2, 'https://i.gyazo.com/ca93ffa87eb76b4883eafc07b8ca8734.png', 'Our latest collaboration that we brewed with our friends from Suburban, Newtown and Simple Days breweries. Flavors of orange, papaya and a little touch of Pacific Northwest. Make this the very not blue part of your week/weekend'),
    (6, 'Poplar Pils', 'Hard Seltzer', 6, 5, 'https://mainstaybrewing.com/uploads/images/mainstay_poplar_pilsner.png', 'Imported malt from Bavaria combines with Tettnang and Hallertau hops to create a bone-dry brew with a bracing hop forwardness. Light bodied, dry and full of Nobel hop aroma.'),
    (6, 'King Laird Weisse', 'Wheat Beer', 6, 5.3, 'https://mainstaybrewing.com/uploads/images/kinglaird.png', 'At one time in Bavarian history, wheat beer was only brewed by royal license at the King’s brewery. This traditional Hefe Weitzen is brewed in honor of Rolston Laird, an Irish immigrant who lived and farmed wheat on Petty Island. Laird was pronounced King of Petty Island in the late 1800s.'),
    (6, 'Harness Bend', 'India Pale Ale', 4, 5.7, 'https://mainstaybrewing.com/uploads/images/harnessbend.png', 'Harness Bend was created by tying two beer styles together. Long forgotten Decoction Mashing and a traditional German Weisse wort combine with new world American hops to fuel this wheat IPA. Spicy wheat malt and Mosaic, Citra and Cascade hops blend together to mold a balanced hop forward American ale. Unfiltered, firm bodied with notes of peach, mango and citrus.'),
    (6, 'Constitution Lager', 'Lager', 3, 5, 'https://mainstaybrewing.com/uploads/images/mainstay_constitution_lager.png', 'Just as the Constitution established the principle rights of our country, this lager is the foundation for our cold fermented brewing. Imported Vienna and Munich style malts give this beer a rich but delicate malt backbone while Tettnang and Hallertau hops deliver a delicate Nobel hop spiciness and aroma. Cooper, malty, and balanced'),
    (7, 'Space Cowboy IPA', 'Unfiltered IPA', 3, 7, 'https://philadelphiabrewing.com/wp-content/uploads/2022/04/SC_Can_Clean.jpg', 'Unfiltered IPA for a taste that''s out of this world!'),
    (7, 'Harvest From the Hood', 'Fresh-hopped Beer', 4, 7, 'https://philadelphiabrewing.square.site/uploads/1/3/0/2/130266077/s879816252768587221_p291_i3_w1080.jpeg', 'Every autumn we release this fresh-hopped beer brewed with hops grown by Philadelphia Brewing Co.® right in our brewery courtyard, along with more hops grown by friends around Philadelphia like Greensgrow Farms. Harvest from the Hood is brewed on the same day that the locally grown hops are hand picked – giving this brew a juicy, bright hop flavor and aroma.'),
    (7, 'PHL Session IPA', 'IPA', 6, 3.9, 'https://philadelphiabrewing.com/wp-content/uploads/2015/05/PHL_Sweat.png', 'Philadelphia’s hoppy and light session IPA. PHL has all of the hop aroma and flavor that you would expect from an IPA with the alcohol content of a light beer.'),
	(8, 'Birthday Batch', 'Stout - Pastry', 4, 7.6, 'https://assets.untappd.com/photos/2022_12_10/f6ccb7337c515277eb908526ea0d3892_640x640.jpg', 'It''s our Birthday Batch! Brewed with 7 different grains, lactose, brown sugar, cocoa nibs and REAL birthday cake, this syrupy black brew is filled with layers of chocolate flavor that will have you watering at the mouth.'),
    (8, 'Harvest Autumn IPA', 'American IPA', 5, 6.7, 'https://assets.untappd.com/photo/2022_12_10/86619443c92331ce8ea1171c8cc56507_c_1228369118_640x640.jpg', 'Our Harvest IPA is brewed with American hops, cracked barley and hard work as a tribute to what makes our beer so special – the harvest. The deep ruby color evokes a bright autumn mountainside where a warm sweater, a good beer and the gratitude for the seasons are all you need. Cheers to the harvest, whatever it may bring you!'),
    (8, 'Coffee Blonde', 'Blonde Ale', 7, 7, 'https://assets.untappd.com/photos/2022_12_03/67503e3bfa34250452aa834aec192c58_640x640.jpg', 'Blonde Ale featuring Kohana Coffee'),
    (8, 'Dark Thunder Storm King', 'Stout - Imperial / Double', 6, 9.1, 'https://assets.untappd.com/photos/2022_12_11/a4596ddf2234ee06e167f72a2f086201_640x640.jpg', 'A downpour of toasted coconut and coffee meets dense, dark chocolate note of Storm King to deliver an indulgent twist on this bellowed Imperial Stout. Let the thunder roll.'),
    (9, 'Lawn Chair Parking Spot', 'West Coast IPA', 5, 7, 'https://images.squarespace-cdn.com/content/v1/57d21485197aea6d03f1c001/1613426167602-SEVB5PJ679CCNVQTZ9YQ/58B10892-9B3A-4A0A-BE26-0BEDB1636AC3_1_201_a.jpeg', 'One of our favorite styles is a great, fresh, West Coast IPA. This one is piney and resinous, with notes of fresh wild flower meadows and bright citrus. It’s in honor of all Philadelphians who have done what it takes to get that spot. We see you. We love you.'),
    (9, 'Stormy Escapes', 'Imperial Stout', 8, 10.9, 'https://images.squarespace-cdn.com/content/v1/57d21485197aea6d03f1c001/1603832716029-2D9U7TI7DZDT0LT9F4FK/IMG_1133.jpeg?format=1000w', 'Like drinking 85% cacao dark chocolate, with lingering flavors of dried tart cherries, dates, and sticky toffee pudding. (Named for the legendary cow, Stormy, who escaped an Old City nativity scene!)'),
    (9, 'Lawn Chair Parking Spot', 'West Caost IPA', 5, 7, 'https://images.squarespace-cdn.com/content/v1/52393eeae4b05b013e6e213b/1633818067154-KW955B5FEYXH1XR5XEJA/Screen+Shot+2021-10-09+at+6.19.34+PM.png', 'One of our favorite styles is a great, fresh, West Coast IPA. This one is piney and resinous, with notes of fresh wild flower meadows and bright citrus. It’s in honor of all Philadelphians who have done what it takes to get that spot. We see you. We love you.'),
	(10, 'Out Of Line', 'Hazy IPA', 4, 7, 'https://breweryars.square.site/uploads/1/3/1/2/131260309/s866874591780701212_p720_i1_w941.jpeg?dpr=1', 'Hazy india pale ale brewed with all motueka hops'),
	(10, 'Penny Candy Hazy Double IPA', 'Hazy Double IPA', 4, 8, 'https://breweryars.square.site/uploads/1/3/1/2/131260309/s866874591780701212_p715_i1_w942.jpeg?dpr=1', 'Hazy double IPA hopped with HBC 630, citra, & simcoe'),
	(10, 'Waynes Pale Ale', 'Hazy Pale Ale', 4, 5.7, 'https://breweryars.square.site/uploads/1/3/1/2/131260309/s866874591780701212_p713_i1_w1476.jpeg?width=1280&dpr=1', 'Our flagship hazy pale ale hopped with citra, simcoe & mosaic hops Tasting Notes: Citrusy sunshine on a cloudy day. This beer is named after our dear old man who has Parkinson''s Disease. A portion of the sales of every pint goes straight to Parkinson''s Disease research. Drink up.'),
	(10, 'Taking A Break From Life Watermelon Gose', 'Gose', 4, 5, 'https://breweryars.square.site/uploads/1/3/1/2/131260309/s866874591780701212_p687_i1_w905.jpeg?dpr=1', 'Gose brewed with watermelon, coriander, & a touch of fleur de sel | 5% ABV Tasting Notes: All the sweet and juicy watermelons followed by a refreshingly tart finish'),
	(11, 'Dime Piece - 2021 ', 'Belgin Quadrupel', 9, 10, 'https://assets.untappd.com/site/beer_logos_hd/beer-5102090_815f9_hd.jpeg', 'This Belgian Quad is made exclusively with PA malts from Deer Creek and then aged in New Liberty whiskey barrels for three months. Aroma gives up a hearty yeasty spice character of cinnamon toasted malt and caramelized candy sugar. Flavor notes of candied orange vanilla and charred peach'),
    	(11, 'Night Howler - 2021', 'Stout - Imperial / Double Oatmeal', 10, 10.1, 'https://assets.untappd.com/site/beer_logos_hd/beer-4557263_d2a11_hd.jpeg', 'After taking 2020 off the Night Howler is excited to return in 2021! Aged in New Liberty Whiskey Barrels, this rich imperial stout boasts a strong barrel flavor with delicious notes of chocolate, coffee, vanilla and a touch of cinnamon. We hope you enjoy this year’s release. Cheers!'),
    	(11, 'Chump Change', 'IPA - American', 6, 6.8, 'https://assets.untappd.com/site/beer_logos_hd/beer-3814244_2dd41_hd.jpeg', 'This IPA is the little brother of Straight Cash, Homie. Same killer hop blend of Citra and Mosaic at a more session-able ABV.'),
    	(12, 'DOCK STREET FUTURO ', 'ITALIAN PILSNER', 8, 4.8, 'https://s3-media0.fl.yelpcdn.com/bphoto/IPJfaCh8dd6ZmY7XcI0_uA/l.jpg', ' A nod to Dock Street''s founder, an Italian immigrant. A grist of German Pilsner malt is carefully decocted to develop a delicate and crisp malt base, onto which an assertive noble hop profile is built with frequent kettle additions of Hallertau Tradition, Hallertau Blanc, and Styrian Aurura. Dry hopped post fermentation with Blanc and Aurora, then lagered extensively. Dynamic flavor and aroma of herbal nobility, soft melon, and blooming wildflowers. Unfiltered and unpasteurized, served in the Keller-Style.'),
    	(12, 'Dock Street WINTER HAZE', 'WINTER HAZE',7, 5.2, 'https://images.squarespace-cdn.com/content/v1/55c8df6be4b051f0536b7701/a2063838-76ea-49c2-b466-ca9a841f0ab0/winter+haze+can+label.JPG', 'The sky is the brightest blue we’ve seen in a while, and the air is so crisp and clear you might just forget traffic jams on 76 and potholes that could swallow your car whole. The only thing to do now is grab a sled and head to the Philadelphia Museum of Art steps for some legendary sledding with friends - and some Dock Street Beer. This wintry version of our seasonal Pale Ale showcases spelt and wheat malt, orange peel, and an abundance of Simcoe hop additions, and perfectly pairs with cold noses and warm fires.'),
    	(12, 'DOCK STREET BOHEMIAN PILSNER', 'DOCK STREET BOHEMIAN PILSNER', 5, 5, 'https://whatnowphilly.com/wp-content/uploads/sites/14/2022/05/Dock-Street-Brewery-To-Open-Tasting-Room-In-Fishtown.jpg', 'This classic, Czech-style pilsner has been our flagship beer since 1985! Brewed in the style of the original pilsner beers of Bohemia in a tradition that dates back to 1842. We use pilsner malts and a generous amount of Bohemian Saaz Hops to produce a golden color, soft, nutty malt flavor and floral hop bouquet.'),
    	(13, 'Plugstreet', 'Belgian Blonde', 6,6.9, 'https://static.wixstatic.com/media/745f6c_b4e228eeb812400ab333aa35205b320e~mv2.jpg/v1/fill/w_809,h_809,al_c,q_85,usm_0.66_1.00_0.01/745f6c_b4e228eeb812400ab333aa35205b320e~mv2.jpg', 'This classic Belgian Style beer is bright with fruity esters and notes of spice. It has a slight malty-sweet flavor and beautiful dry finish. '),
    	(13, 'Prolonged Forms', 'Session Ale', 6, 4.4, 'https://static.wixstatic.com/media/745f6c_f374191697124f7683b6363f77c27a39~mv2.jpg/v1/fill/w_809,h_809,al_c,q_85,usm_0.66_1.00_0.01/745f6c_f374191697124f7683b6363f77c27a39~mv2.jpg', 'Super light,easy to drink, but packed full of flavor, this balanced session ale is brewed with German malts and noble hops. Crushable...'),
    	(13, 'Tiger Smile Hazy', 'Belgin Quadrupel', 6, 7.0, 'https://static.wixstatic.com/media/745f6c_874798625c744a97850e4580909e2ee5~mv2.jpg/v1/fill/w_809,h_809,al_c,q_85,usm_0.66_1.00_0.01/745f6c_874798625c744a97850e4580909e2ee5~mv2.jpg', 'Whirlpooled with Sabro and Mosaic hops after the boil, Tiger Smile is a tropical juice coconut explosion with a slight bit of minty bitterness.  It will put a smile on your face.'),
    	(14, 'Devil''s Pool ', 'Double IPA', 5, 9, 'https://wissahickonbrewing.weebly.com/uploads/1/3/1/3/131304840/s306811436750755545_p97_i12_w1080.jpeg', 'Award-winning Double IPA dry hopped w/ Citra & Simcoe.'),
    	(14, 'Frūx: Cranberry Tangerine ', 'Sour - Fruited', 4, 6.5, 'https://wpcdn.us-midwest-1.vip.tn-cloud.net/www.honolulumagazine.com/content/uploads/2022/03/t/q/hana-koa-brewing-shootz-da-bootz-pc-hana-koa-brewing-co.png', 'Fruited Sour Ale w/ cranberry & tangerine purée. Contains lactose.'),
    	(14, 'Gazebo: Peach', 'Hard Cider', 4, 6.5, 'https://i0.wp.com/thecrafthiker.com/wp-content/uploads/2022/05/PXL_20220501_180122293-scaled.jpg?ssl=1', 'Hard Cider w/ Peach Purée. Gluten free.'),
    	(15, 'KNOCKIN’ ABOUT', 'Golden Ale', 5, 4.9, 'https://assets.untappd.com/photos/2022_12_11/fe39c1222b9d547bb7af4c741090968e_raw.jpg', NULL),
    	(15, 'I FOUND MYSELF A QUIET PLACE', 'aLTBIER', 4, 5.3, 'https://assets.untappd.com/photos/2022_10_12/daca3c2ca2bb7da6a479c03f65c40985_640x640.jpg', 'Whole wheat toast, Caramel'),
    	(15, 'SINGLE COIL ON TAPE', 'IPA - New England / Hazy', 6, 7.2, 'https://assets.untappd.com/photos/2022_06_19/38280ee5345ee1173d49cebf1709eeb8_640x640.jpg', 'Fuzzy IPA made with Citra, Oats, and a touch of Eukanot. Notes of dank grapefruit, honey, and creamy oats.'),
    	(16, 'ULTRA GALAXY', 'Double Dry Hopped Imperial ', 7, 8, 'https://assets.untappd.com/photos/2022_11_23/08759db051bbeed1fc320e2017478a81_640x640.jpg', 'We got our hands on some Galaxy hops from Australia’s latest ‘22 hop harvest and, after some sensory analysis and experimentation, we were blown away and decided it was time to bring back Ultra Galaxy to showcase this year’s exceptional crop. Ultra Galaxy pours a beautifully hazy, light yellow-orange hue into a glass and bursts with intense aromas of ripe peach and juicy passionfruit. We softened the mouthfeel of this imperial IPA by adding a large portion of malted wheat and oats in the mash and kept the bitterness restrained to accentuate a juicy finish characterized by delicious hop flavors. Ultra Galaxy was hopped in the whirlpool and then twice more during active fermentation with 100% Galaxy hops. We get notes of ripened peach, tropical passion fruit, juicy tangerine wedges, sweet, resinous pine, apricot marmalade, bright clementine, mango, and lemon Starburst.'),
    	(16, 'GOOOAL!', 'Session Ale',8,7 , 'https://assets3.thrillist.com/v1/image/3014845/1000x666/flatten;crop;webp=auto;jpeg_quality=60.jpg', 'Fruited Smoothie Sour Conditioned on Cherry, Cranberry, Pomegranate, & Sicilian Blood Orange GOOOAL! is a heavily fruited sour ale that we brewed with a base of pale barley malt, wheat malt, and flaked oats. It was fermented with a special, lactic acid producing yeast strain and then conditioned on red morello cherry, cranberry, pomegranate, and Sicilian blood orange. GOOOAL! pours a reddish-pink hue into a glass and leaves behind frothy rings of fruity foam with each gulp. It opens with aromas of sweet, seasonal fruit punch, drinks with a luscious medium body, and closes with a refreshingly tart, fruity finish. We get notes of cranberry juice, grapefruit bubbly, autumnal fruit punch, tangerine, morello cherry, crushed pomegranate, and orange soda.'),
    	(16, 'ENTER THE DRAGON', 'Double IPA', 5, 7, 'https://assets.untappd.com/photos/2022_12_05/9432b9a2fde9ade80414bbae05902312_640x640.jpg', 'Fruited Smoothie Sour Conditioned on Red Dragon Fruit and Mixed Berry Enter the Dragon is a heavily fruited sour ale that we brewed with a base of pale barley malt, wheat malt, and flaked oats. It was fermented with a special, lactic acid producing yeast strain and then conditioned on red dragon fruit and mixed berries (strawberry, blakberry, blueberry, and currant). Enter the Dragon pours a deep, vibrant red with violet hues into a glass and leaves behind frothy rings of fruity foam with each gulp. It opens with aromas of sweet berries and exotic tropical fruit, drinks with a luscious medium body, and closes with a refreshingly tart, fruity finish. We get notes of red dragonfruit smoothie, candied hibiscus, blackberry jam fizz, SweeTart candies, red Starburst, strawberry Fanta, and blended wild berries.'),
    	(17, 'POETR SNAPS', 'Lager', 9, 4.5, 'https://birrapedia.prevista.net/modulos/market/77/44/other-half---poetry-snaps-16614253876788-g.jpg', 'A rice lager in the Japanese style with pils malt and rice plus a beautiful blend of some of our favorite European hops, Czech Saaz and German Saphir. Dry and crisp with a slightly spicy character, followed by floral and sweet citrus. Super crushable for some warm weather hangs or any type of weather if you ask our brewers.'),
    	(17, 'GRAVY BITS', 'PILSNER - ITALIAN', 8, 5.1, 'https://www.sparrowine.com/media/catalog/product/cache/4affeeb0391b580bb11202aa0f1726bb/0/1/01290.jpg', 'You know when you are cookin and you got them delicious lil'' brown bits in the bottom of the skillet and ya just can''t wait to turn ''em into gravy? That is how we feel about Tettnang and Saaz. Sure, Floor Malted Pils and Munich make a tasty beer, but the hops... those are the gravy bits!"'),
    	(17, 'DOUBLE FOREVER CASHMERE', 'Imperial IPA', 8, 8.5, 'https://www.totalwine.com/dynamic/x490,4pk/media/sys_master/twmmedia/hff/h2f/15103315705886.png', 'Our hand selected Cashmere goes into this single hop Imperial IPA. Cashmere is an interesting hop that gives candied lemon and fruity pebbles notes and is clean and bright on the finish.'),
    	(18, 'Four Seam', 'New England Style IPA ', 8, 5.5, 'https://baseballismy.life/wp-content/uploads/2019/05/idle-hands-four-seam-NE-IPA.jpg', '- bursts of citrus, mango, and guava Conjures up thoughts of a tropical paradise with bursts of citrus, mango and guava that sit on top of a refrained malt backbone. Bitterness remains subdued to allow the true character of the hops to shine through while the cloudy appearance elevates the experience.'),
    	(18, 'Gretel', 'German Pilsner ', 8,7, 'https://massbrewbros.com/wp-content/uploads/2020/07/0-6.jpeg', 'We brewed Gretel with a very traditional focus using 100% noble hops and a simple grain bill. The result is a snappy Pils with a light grassy character and touches of spice in the finish.'),
    	(18, 'Farmhouse', 'American Farmhouse Ale ',9, 8, 'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/8ac5c1125870035.612248c68bd5e.jpg', '- notes of stonefruit and pepper Easy drinking farmhouse ale with an American twist. Notes of stone fruit, tropical fruit and bubblegum with a dry peppery finish.'),
    	(19, 'Iron Hill Light Lager', 'Lager - American Light', 5, 4, 'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/h3b/h9a/16574539464734.png', 'Our lightest beer. Brewed to give a crisp, clean, refreshing taste with very subtle malt and hop flavor.'),
    	(19, 'Hipster IPA', 'IPA - New England / Hazy', 5, 6.7, 'https://d3omj40jjfp5tk.cloudfront.net/products/5fc50f992ecffb271c25b265/large.png', 'This hazy, New England style IPA’s been crafted by our finest, tight-pants wearing brewers. It’s a blend of wheat and oats, unironically dry hopped with All American hops. Notes of melon, mango and pine lead to flavor so cool it’ll curl your mustache.'),
    	(19, 'Spruce Moose IPA', 'PA - New England / Hazy', 6, 6, 'https://www.ironhillbrewery.com/assets/craft/cans/_beerCanTransform/spruce-moose-can.png', 'This new wintertime classic from Iron Hill is not only made for sippin’ around the tree, it’s made from the tree! Brewed with spruce needles and a generous kick of Chinook and Simcoe hops, this seasonal IPA balances a crisp flavor with intense aromas of pine and citrus. So here’s to winter! The Moose is loose!'),
    	(20, 'Wicked Wolf', 'IPA - Black / Cascadian Dark Ale', 8, 6.8, 'https://www.noonwhistlebrewing.com/wp-content/uploads/2020/04/noon-whistle-gummytron.png', 'This hoppy black ale brings resinous pine character from Chinook hops combined with English yeast character that brings out mild caramel and dark roasted malt flavor. The slight residual sweetness provides the perfect balance to this limited seasonal release 6.1%'),
    	(20, 'Confuse the Robot', 'Mild - Dark',8, 6.7, 'https://www.noonwhistlebrewing.com/wp-content/uploads/2020/04/noon-whistle-paranormal-gummy.png', 'Next time a robot posing as a human calls to sell you something have a little fun! This malt-forward experience gives your hop senses a break while showcasing several dark malts with notes of caramel, dried fruit and burnt sugar. Own those robo-calls!'),
    	(20, 'This Is the Way', 'Schwarzbier', 6, 5.1, 'https://www.noonwhistlebrewing.com/wp-content/uploads/2020/04/noon-whistle-gummysicle.png', 'Imagine decadent chocolate without the guilt! This German inspired brew is your fall ‘Go-To’ for a seasonal craft beer change up. It lands at an easy 5.1% with a balanced profile that will leave you taking home a 4-pack to avoid withdrawal.'),
    	(21, 'Swing Juice ', 'Hazy Pale Ale', 7, 5.5, 'https://images.squarespace-cdn.com/content/v1/5fe20bb74fdecd01ce4fe193/1610996680208-6Q01TXL369I0O07VG2UW/easy+way+ipa.jpg', 'Brewed with a touch of Munich malt and a lot of Waimea, wai-iti, and Galaxy hops.'),
    	(21, 'ROTH', 'IPA', 4, 5.5, 'https://dydza6t6xitx6.cloudfront.net/ci-21st-amendment-blah-blah-blah-97c67936ffe09cbf.png', 'Each sip pays dividends with a sweet, then bitter tropical citrus punch.'),
    	(21, 'Salem Soup', ' Fall Spiced Brown ale ', 100, 6.5, 'https://beverages2u.com/wp-content/uploads/2021/07/21st-amend-tasty-double-hazy-IPA-1.png', 'A Fall spiced Brown ale that is ready for winter. This was brewed with 15lbs of brown sugar roasted pumpkins, ginger, nutmeg, cinnamon, and organic Madagascar vanilla beans. It has a subtle pumpkin pie flavor with notes of toasted marshmallow and White mocha'),
    	(22, 'Bootlegger’s Pils', 'Strong Pilsner', 8, 6.5, 'https://images.freshop.com/00000001214895/cffd74881b1f42dd23dc62f9feac4dee_4f79e958-a083-4d63-8cc9-afd3908d5c79_large.png', 'This is a recipe from an infamous bootlegger producing beer in a remote area in Northeast Philadelphia during prohibition. He couldn’t keep up with demand for his product, so he doubled down on the alcohol to make his Pilsner style beer twice as strong.'),
    	(22, 'SunDaze FunDaze', 'Wheat Ale', 7, 6.2, 'https://images.freshop.com/00853272006894/b760fde97264dc577110f72b1747d98e_large.png', 'SunDaze FunDaze helps you forget that in less than 24 hours, you have to work again. Better yet, this beer should be enjoyed every day of the week. Brewed with Oats and Wheat Malts, Citra, Mosaic, and Mosaic joined the whirlpool and dry hop to impart Citrusy, Pine, and Sweet Fruit flavors.'),
    	(22, 'General Grant Stout', 'Dry Stout', 6, 5, 'https://images.freshop.com/00853304008186/65ef98b71a853155b6064b4485d95f4b_large.png', 'A dry stout brewed with Roasted Malts that impart a dark chocolate flavor.'),
    	(23, 'Lil Thrills', 'Pilsner - German', 4, 5.9, 'https://craftypint.com/thumb/200x400/fit/https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Ken-Oats-210913-131519.png', 'German pilsner, notes of lemon verbena, sweet bread and floral tones'),
    	(23, 'Day Lite', 'Lager - American', 6, 4, 'https://craftypint.com/thumb/200x400/fit/https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Strata-Smash-210611-125939.png', 'Crisp and crushable. Day Lite features cara cara orange peel for a refreshing, gently sweet citrus flavor. Brewed with white wheat for a smooth body and slightly hazy appearance. Only 100 calories.'),
    	(23, 'Santilli', ' IPA - American', 6,6, 'https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Pillow-Talk-210524-202552.png', 'Santilli is an award-winning, crowd-sourced American IPA named after the brewery’s street address in Everett, MA. It''s also winner of the Bronze Medal in the American IPA category at the 2016 World Beer Cup.Santilli pours bright gold with a nose of grapefruit zest and pine needles. It begins with big citrus flavors and a light, malty sweetness, finishing clean, pleasantly bitter, and crisp.'),
    	(24, 'ROCKY RIDGE ROCK CANDY', 'Fruit Sour', 8, 5.5, 'https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Rock-Candy-221117-213947.png', 'Amid the constant flow of limited and seasonal releases, Rocky Ridge have expanded their core range with a refreshingly tart, fruited sour in the form of Rock Candy – a beer five years in the making that should slot effortlessly into the creative lineup from the Jindong brewers.Passionfruit, kiwifruit and strawberry all feature in the beer''s fruit forward palate while retaining a pleasing drinkability. A short but sharp finish cleanses the palate with each sip, further enhancing its fruity, refreshing nature, while 5.5 percent ABV hints at repeatability – at least when sat alongside many of their far larger concoctions.It makes for a simple but entirely effective offering from Rocky Ridge, with Rock Candy a great all-rounder for those looking for a fruit-leaning sour existing well away from lactose-laden pastry bombs.'),
    	(24, 'ROCKY RIDGE JINDONG JUICY', 'Juicy Pale Ale', 7, 5.5, 'https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Jindong-Juicy-211213-173022.png', 'Brewer''s notes: Pouring with a medium level of hop haze, this juicy pale ale is loaded with tropical fruit and citrus characteristics that are complemented nicely by a low yet cleansing level of bitterness. Well-balanced, highly sessionable and packed with flavour, texture and aroma - it really is a beer for all occasions.'),
    	(24, 'ROCKY RIDGE BABY PEACH', 'Fruited Session IPA', 5, 4, 'https://craftypint.s3.amazonaws.com/crafty/beer/Rocky-Ridge-Baby-Peach-211213-173128.png', 'Brewer''s notes: Live with vibrant peach aromas, this smooth and highly enjoyable fruited IPA has a low level of bitterness that is complemented by a soft & creamy mouthfeel. Made using natural puréed fruit, a lower ABV makes this a highly sessionable beer that is unlike anything else.'),
		(24, 'Example Beer Name', 'Example Style', 100, 5, 'Image url', 'Example Description'),
		(25, ' Hallertau Pils', 'German-Style Pilsner', 7, 5.2, 'https://breweriesinpa.com/wp-content/uploads/2021/01/Screen-Shot-2021-01-27-at-9.38.52-PM.png', ' Hallertau pils is brewed as an ode to the industrial German pilsners of the 50’s to the late 70’s when technology allowed more efficient processes, but the liquid was still brewed “the old way”. We use a double decoction mash, 100% German Pilsner malt, and 100% German Hallertau Mittlefru hops..'),
		(25, 'Rauchschloss', 'Bamberg-style Smoked Amber Lager', 6, 5, 'https://assets.untappd.com/photos/2022_11_15/1b28a3a49ee317a47304fc9ab3002af1_640x640.jpg', ' Brewed with 100% beechwood smoked malt from Weyermann malting in Bamberg, Germany, and 100% German grown Hallertau Mittlefru hops. We brew this beer using the same Franconian style, single decoction mash as our Burgenstrasse, gleaned from an 1865 brewing manual.'),
		(25, 'Single Axis Mosaic', 'IPA', 5, 6.5, 'https://kaedrin.com/beerblog/wp-content/uploads/sites/3/2021/01/humanrobot-singleaxiscitra.jpg','This beautiful IPA is hopped exclusively with an overwhelming amount of luscious Mosaic. Close your eyes and take a magic carpet ride through fields of blueberry hubba bubba, mixed berry compote and mango jelly.'),
		(26, 'Formation 2020', 'IPA', 8, 6.2, 'https://www.fermenteryform.com/wp-content/uploads/2021/07/52420FAB-37E4-42A6-A1DC-A3E49127FE8E-1024x1024.jpg', 'This batch of Formation was blended from 4 oak barrels of about 1 year in age. This batch is juicy, spicy and with a moderate earthy acidity. Bottles are 750ml, and $18 each. Batch #3 was released in February, 2021.'),
		(26, 'SLO-MO 2020', 'IPA', 8, 6, 'https://www.fermenteryform.com/wp-content/uploads/2021/07/IMG_3563-768x1024.jpg', 'SLO-MO 2020 was blended from 2 year old barrels from our Solera, and aged on cherry and blackberry purée. It tastes of bright, lush cherries, with just a touch of blackberry jam, finishing light and refreshing. 6%, 750ml, $21 each. Batch #3 was released in February of 2021.'),
		(26, 'Vieux Selection', 'IPA', 8, 7.5, 'https://www.fermenteryform.com/wp-content/uploads/2020/07/IMG_2559-712x1024.jpg', 'Vieux Selection is the culmination of 3 years of careful beer preservation and maturation in oak barrels. We’ve been inspired to do much of what we do, but the tradition of Belgian Lambic. Our favorite being Geuze, the blend of 1, 2 and 3 year old barrel aged beers. While our process differs from traditional Lambic in significant ways, the inspiration still comes through in the bottle. This beer has complex layers of flavor that come from the careful selection of barrels to blend. The aroma is earthy, minerally and spicy, the taste is a balance of tart fruits, woody resinous sweetness, and pithy bitterness. While being one of the most complex beers we have ever made, it’s still easy to drink. Bottles and draft, 7.5% abv. Released June of 2020.'),
		(27, 'SOUR BATCH KEHD', 'Raspberry Berliner Weisse', 5,4.6, 'http://cheekymonkeyboston.com/wp-content/uploads/2017/07/3-SOUR.png', 'Light in body, sour tartness upfront with a raspberry candy finish'),
		(27, 'HARAMBE''S GHOST', 'Double IPA', 8, 8.4, 'http://cheekymonkeyboston.com/wp-content/uploads/2017/07/5-DOUBLE-IPA.png', 'This brew is a big, robust deep amber IPA with a distinctive white, rock head.Hops, citrus, malt, pine, caramel and sweet malt backbone provide for a beautiful balance that finishes with lingering bitternes and citrus.'),
		(27, 'REBELLIOUS MONK', 'Stout', 6, 6, 'http://cheekymonkeyboston.com/wp-content/uploads/2017/07/4-STOUT.png', 'Deep black in color.Roasted malt, coffee and dark chocolate flavor with subtle hop profile and creamy finish.'),
		(28, 'GOOD GOOD', 'DOUBLE INDIA PALE ALE', 8, 8, 'https://d3omj40jjfp5tk.cloudfront.net/products/5dc769cdef17f81a69b4d4e6/large.png', 'A hazed-out, new school, fan favorite DIPA, double dry-hopped with a blend of Simcoe, Citra and Centennial hops. This beer boasts a pillowy mouthfeel with soft lingering bitterness. Its big fruity punches are balanced by pangs of spruce sap, pine and notes of resin.'),
		(28, 'CLASSIC CREAM', 'AMERICAN CREAM ALE', 6, 5, 'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/hca/hcc/15421659414558.png', 'Our quintessential American Cream Ale made for drinking any time, and day. Comprised of Bohemian Pilsner malt and flaked maize, hopped gently with Hallertauer, then fermented low and slow for 3 weeks with a very cool ale strain, this beer is as crisp and easy drinking as they come.'),
		(28, 'FRUITY DABS', 'DOUBLE INDIA PALE ALE', 9 ,8.7, 'https://d3omj40jjfp5tk.cloudfront.net/products/5ea4bfac2acaf624d1fa621a/large.png', 'A tropical double India Ale Pale, double dry-hopped with Centennial, Citra and Azacca hops, then conditioned on orange peel and vanilla for a citrusy punch. This tropical DIPA boasts distinct citrus tones with creamsicle and vanilla vibes, balanced by a hazy and resinous mouthfeel.'),
		(29, 'I SAID WHAT I SAID', 'KEY LIME MARGARITA SOUR',4, 5, 'https://assets.untappd.com/site/beer_logos_hd/beer-4787185_c528f_hd.jpeg', 'This light blonde ale has been fermented with a special hybrid sour yeast for the perfect level of acidic tartness and then dosed with natural margarita flavor. No blender required.'),
		(29, 'THERE’S NO CRYING IN BASEBALL', 'HAZY MANGO IPA', 8, 6, 'https://assets.untappd.com/site/beer_logos_hd/beer-3692046_f4843_hd.jpeg', 'A hazy IPA with natural mango flavor and a wicked curveball. Light, hazy, and refreshing, this beer is packed with flavor from hefty dry-hopping and natural mango. You could say it’s in a league of its own.'),
		(29, 'PURPLE MONKEY DISHWASHER', 'CHOCOLATE PEANUTBUTTER PORTER', 8, 6.7, 'https://dth50iqs19w2y.cloudfront.net/de/f527aeb0344a089545a5b77dd59c9d/Evil-Genius-Purple-Monkey-Dishwasher-Chocolate-Peanut-Butter-Porter.png', 'If candy and beer had a beautiful liquid baby. Do you like chocolate and peanut butter but hate all that pesky chewing? Give your teeth a vacation with our rich, full-bodied chocolate peanut butter porter.'),
		(30, 'Daddy Fat Sacks', 'IPA - American', 3, 6, 'https://images.squarespace-cdn.com/content/v1/53397a25e4b012d5a0b5039f/1449962985396-1TBTDUSDQ5YUH9ZN3LDJ/image-asset.jpeg', 'Our flagship IPA, named for all the fat sacks of dank hops that are used in the dry hop. Brewed with quality American 2-Row leaving a blank slate for the hops to explode. Hopped lightly during the boil and dry hopped excessively with Citra and Cascade. An awesomely dry IPA with tropical fruit and grapefruity goodness.'),
		(30, 'Sour Hound', 'American Sour Ale', 4, 4, 'https://images.squarespace-cdn.com/content/v1/53397a25e4b012d5a0b5039f/1443123066845-EAZC659GZ4T9J86W2CVR/image-asset.jpeg', 'Tart and fruity, this traditional German wheat ale gets kettle soured and is fermented with fresh blueberries and blackberries. This red ale is sour, refreshing and reeks of fruit.'),
		(30, 'Ludwigs Revenge', 'German Style Dark Lager', 5, 5.25, 'https://images.squarespace-cdn.com/content/v1/53397a25e4b012d5a0b5039f/1442789321962-LNYVCPKO6ZRAF5W0G6PT/image-asset.png', 'A smooth brown toasty German lager that expresses the beauty of malt. We emulate the traditional style that has always been popular in Germany and give it our own artistic twist. Malty, caramel, meaty, full bodied but clean.'),
		(31, 'El Capitan', ' Lager - Pale', 5, 4.8, 'https://www.totalwine.com/dynamic/490x/media/sys_master/twmmedia/ha6/h00/15233811709982.png', 'A Mexican-style Cerveza that is light and crisp. A lager brewed with Flaked Corn to deliver an extra dry finish. This beer is highly effervescent and extremely refreshing.'),
		(31, 'Almanac', 'German-Style Pilsner', 6, 6.1, 'https://d3omj40jjfp5tk.cloudfront.net/products/61be9f6fb48440379370d52d/large.png', 'LOVE is bursting with hoppy tropical flavors. Built on a simple base of Pilsner malt and rolled oats, this super dank IPA has a pillowy mouthfeel and is double dry-hopped with Mosaic, Citra and Simcoe. Flavors of mango, cantaloupe, and citrus will keep you infatuated.'),
		(31, 'Foreign Objects Wet Gravity', 'Dry Stout', 5, 5, 'https://d3omj40jjfp5tk.cloudfront.net/products/608c0760fb70287e109b0cf3/large.png', 'The density of our beloved hop essence in this gorgeous silken beer drips down from your head and soaks your feet. We hopped this densely with the eternally saturating Citra and Azacca hop varieties. The aromas of passion fruit, mango, and deep citrus-resin will drag you down by the river''s edge like rocks in your pockets, showing through like the deep brainsqueals and infinite pulse of gravity clinging to your senses and calling you home from across the furthest extremes of creation immensity.'),
		(32, 'New Belgium Voodoo Ranger', 'Hazy Imperial IPA',8, 9.5, 'https://d3omj40jjfp5tk.cloudfront.net/products/630e3e5a432ffb2599149217/large.png', 'Juice Force is a fruit forward, highly drinkable, 9.5% ABV blast. Buckle up, with this hazy IPA you''ll be buzzing the tower in no time.'),
		(32, '21st Amendment Down To Earth Session IPA', 'IPA',6 ,4.4, 'https://d3omj40jjfp5tk.cloudfront.net/products/5831dedd36d5f325c901fdcd/large.png', 'Whether you have a long mission behind you or a full afternoon ahead, this session IPA will help keep things real. More relaxed than an IPA, but with all the hop aroma and flavor, Down to Earth is our tribute to unsung heroes and unplanned adventures. Down to Earth is the natural evolution (pun intended) of Bitter American, our original session ale. We thought it would be fitting to bring our space chimp home and let him chill. Down to Earth is available year-round in 6 pack cans and on draft and pairs nicely with a variety of things, including lunch.'),
		(32, 'Hoptimum', 'IPA - Triple', 8, 11, 'https://d3omj40jjfp5tk.cloudfront.net/products/60886fdee2bc5a7c7e90d92a/large.png', 'A group of hop-heads and publicans challenged our Beer Camp brewers to push the extremes of whole-cone hop brewing. The result is this: a 100 IBU, whole-cone hurricane of flavor. Simply put —Hoptimum: the biggest whole-cone IPA we have ever produced. Aggressively hopped, dry-hopped, AND torpedoed with our exclusive new hop varieties for ultra-intense flavors and aromas.Resinous “new-school” and exclusive hop varieties carry the bold and aromatic nose. The flavor follows the aroma with layers of aggressive hoppiness, featuring notes of grapefruit rind, rose, lilac, cedar, and tropical fruit—all culminating in a dry and lasting finish'),
		(33, 'Monk From the ''Yunk''', 'Belgian Tripel', 7, 9.1, 'https://assets.untappd.com/photos/2021_07_07/483c2164301cd12564c004261645322c_640x640.jpg', 'This strong, golden colored ale is brewed with pilsner malt and noble hops, but it is the traditional Belgian strain of yeast that provides the complex aromas of fruit and spice. With a dry finish and relatively light body, you will find our Belgian Tripel very drinkable for a beer this potent.'),
		(33, 'Crunch', 'American Porter', 5, 6, 'https://assets.untappd.com/photos/2022_06_19/25c31cd7a1c98629fcf79379dd26ddc4_640x640.jpg', 'Chocolate and peanut butter come together in perfect harmony to create Crunch, our luxurious and decadent spin on our traditional porter. With bold chocolate and coffee notes, Crunch is rich and smooth with an insane malt profile and delightful roasty peanut aroma.'),
		(33, 'French Toast Crunch', 'American Porter', 6, 6, 'https://assets.untappd.com/photos/2021_01_31/0b6b2c69e3e7381c97dc0c929684b788_640x640.jpg', 'The earliest recipes for French Toast can be found dated back to the 4th century. Our version, French Toast Crunch, is a modern-day spin on the classic and is a roasty porter brewed with cinnamon and maple syrup, with a whisper of lactose for added sweetness.'),
		(34, 'Phoebe', 'Farmhouse Ale - Bière de Garde', 4, 6.2, 'https://scontent-mia3-2.xx.fbcdn.net/v/t39.30808-6/317338326_568762795257688_4403127922715583735_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=730e14&_nc_ohc=3Sm1VOMbx94AX8d75H9&_nc_ht=scontent-mia3-2.xx&oh=00_AfCTNYxS7kUZ21ro2uMNG6vJX03CXclIM3hYAb4V9iu4kA&oe=639E6D87', 'Our favorite girl is back on draft and available in cans for takeout. Stop by for a dose of sunshine on this dreary day!'),
		(34, 'Cherry Bomb', 'Other', 4, 6.2, 'https://scontent-mia3-1.xx.fbcdn.net/v/t39.30808-6/313402803_536703691796932_4704448378414105962_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=730e14&_nc_ohc=x_E-6bpSY20AX9_WYm6&_nc_ht=scontent-mia3-1.xx&oh=00_AfCFmeP3-vY9Ua2KItq-nWM6IwzX_WLxo90uedPL4D23iA&oe=639EAFC8', '🎶 Hello daddy, hello mom I’m your ch-ch-ch-Cherry Bomb 🎶 Now available in singles, doubles, triples, and four baggers. Stop by and stock up for the Series!'),
		(34, 'Mojo', 'Wheat Beer - Witbier / Blanche', 4, 5.2, 'https://scontent-mia3-2.xx.fbcdn.net/v/t39.30808-6/294025470_3278119699082970_7095080318464716994_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=a26aad&_nc_ohc=GO7fqEzn2_8AX_oUqdt&_nc_ht=scontent-mia3-2.xx&oh=00_AfACDgxBcFwRvH_CSXoVivsJw-CrD10ikTE-_uk8mK6cPA&oe=639E7BC6', 'Witbier brewed with mint and lime'),
		(35, 'Trendler Pilsner', 'German Pilsner', 4, 5, 'https://i0.wp.com/absolutebeer.com/wp-content/uploads/2020/06/AB-Breweries-Tired-Hands-Brewing-Company-Locations-Brew-Cafe-Interior-1-Photo.jpg?fit=1800%2C1200&ssl=1', 'Brewed with all German Pilsner malt and hopped emphatically with Spalter Select from our most recent German selections, Trendler Pilsner is then fermented with our house lager yeast and cold conditioned for many moons. We brew this beer for Jean’s grandfather, Joseph Trendler, but make enough of it to share with everyone! Notes of jasmine flower, white grape, light biscuit dough, green tea, and hay.'),
		(35, 'HopHands', 'Pale Ale - American', 4, 5.5, 'https://cdn.pastemagazine.com/www/articles/HopHands_Main.jpg', 'Our exceedingly aromatic American Pale Ale. Hopped with Amarillo, Centennial, and Columbus. Nuances of tangelo, under-ripe kiwi, and pine needles.'),
		(35, 'Alien Church', 'IPA - New England / Hazy', 5, 7, 'https://assets.untappd.com/photos/2022_12_11/ebc3cf3ff8bceaa2efcfda45e9bca58b_640x640.jpg', 'Alien Church is our Hyper-Speed Reptoid Alien with Photosynthesizing Tongue Oat IPA. Brewed with an abundance of pillowy malted oats and intensely extraterrestrially hopped AND dry hopped with our favorite sticky drippy juicy American varietals. Luscious layers of kiwi smoothie, strawberry candies, blueberry jelly, ruby red grapefruit, bright orange zest, musky tropical fruits, and drippy pineapple.'),
		(35, 'Oblivex', 'IPA - Imperial / Double', 5, 9.2, 'https://assets.untappd.com/photos/2022_12_10/3e89805a66f133dac77a28e47ec29aca_640x640.jpg', 'Oblivex is our Citra & Amarillo Electrified Mummy Double IPA brewed with a huge grist of spelt and oats. Intensely hopped and dry hopped into a bright hellish oblivion with our best Citra & Amarillo. Delightfully creamy, pungent, and extremely citrusy. 9.2% abv. Notes of drippy Jersey peach, Valencia orange juice, cantaloupe, and Meyer lemon.'),
		(36, '“Giant Jim” Tarver', 'IPA - American', 7, 6.5, 'https://assets.untappd.com/photos/2022_10_22/b736e7bd899976cb00feb9566946fea4_640x640.jpg', 'Named after the Giant from Texas, the Jim Tarver has just the right amount of citrusy hop notes, with a smooth dry finish.'),
		(36, 'Top Hat', 'Pale Ale - American', 7, 4.5, 'https://assets.untappd.com/photos/2022_10_08/73aa23558f9c80f36ca399e78b5f406f_640x640.jpg', 'This delicious light beer owes its flavor to the white wheat malts, hopped in citrus, cashmire, and azacca'),
		(36, 'Sideshow', 'Pale Ale - American', 7, 6, 'https://assets.untappd.com/photos/2022_07_23/115376e310fa92c7d16cb0c113b2b943_640x640.jpg', 'Don’t let the name fool you, the full bodied Sideshow can be the main character at any party, is slightly crisp and refreshing with cascading floral notes'),
		(37, 'Tropical Punch', 'Milkshake IPA', 7, 7.2, 'https://assets.untappd.com/photos/2022_09_25/978c89206d12ee7687549e1ce62f9fb1_640x640.jpg', 'Tropical Punch Milkshake IPA. Envisioned with our astral cohorts from @Omnipollo. Brewed with fluffy oats, wheat and creamy lactose sugar. Conditioned atop a bounty of sticky n’ sweet Pineapple, Apricot, Blood Orange, Passion Fruit, and Papaya purée. Further conditioned on a generous helping of Madagascar vanilla beans, and dry hopped intensely with fresh, hand selected Mosaic and Citra. 7.2% abv.'),
		(37, 'Fire Iron', 'Fruit Beer', 6, 8.5, 'https://cdn.shopify.com/s/files/1/2461/7827/products/FireIron-2339_1200x1200.jpg?v=1660060900', 'This Midwest Fruit Tart Ale is brewed with 1,500 lbs of pink guava, 500 lbs of banana, and 400 lbs of passion fruit per 30 bbl batch.'),
		(37, 'Yuzu Mandarin Alien Church', 'IPA - New England / Hazy', 4, 7, 'https://assets.untappd.com/photos/2022_11_27/0eebe757e25a024368c718d0c4bfd0df_640x640.jpg', 'Yuzu Mandarin Alien Church. We fruited our classic Alien Church recipe with the best yuzu and mandarin puree which creates a beautiful balance with our traditional dry hop of Citra, Mosaic, and Chinook. Notes of Limencello, dried orange peel, tangerine, orange marmalade, and your Great Grandmas candy jar.')	,
		(38, 'Sour Cat Razz', 'Sour - Fruited', 4, 6.1, 'https://assets.untappd.com/photos/2021_10_10/3b223b8042bfbdc21ed1f6b91777229c_640x640.jpg', 'very sour upfront with a sweet tart finish. smells a little funky and has a pink hue'),
		(38, 'Curiouser And Curiouser', 'IPA - New England / Hazy', 5, 7.1, 'https://assets.untappd.com/photos/2022_04_16/f1f1582d276864a208a4550e4ec885f4_640x640.jpg', 'Super-hazy NE IPA with a bright, tart tropical fruit infusion.'),
		(38, 'Feelin Froggy', 'IPA - Imperial / Double', 5, 8, 'https://assets.untappd.com/photos/2021_05_16/8e08ae429b35d4df3ad9a58b2c825875_640x640.jpg', 'Bright tropical & citrus notes give way to mellow finish'),
		(39, 'Indecent Proposal Ale', 'IPA - American', 5, 7.5, 'https://assets.untappd.com/photos/2022_08_07/22cacf196156ef26dd00bd1a3209e61c_640x640.jpg', 'Aromatic and hop-forward, Indecent Proposal Ale is crafted with copious amounts of citra, centennial, nugget and mosaic for both floral and citrus notes. The grains take a back seat, imparting subtle malty and caramel flavors designed to leave you wanting more.'),
		(39, 'New Standard', 'Stout - American', 6, 5.2, 'https://assets.untappd.com/photos/2022_04_19/d9bc2e946afb4742241b94f48ad07893_640x640.jpg', 'Velvety mouthfeel, with notes of chocolate, caramel and roasted coffee, its a traditional take on an old favorite—the American Stout. This well-balanced this beer is setting new standards.'),
		(39, 'Bremen Ave Brown', 'Brown Ale - American', 6, 5.8, 'https://assets.untappd.com/photos/2022_09_14/06019cc17656ead22e4aa79ed60e5d75_640x640.jpg', 'Reminiscent of our favorite old-school candy—malted milk balls. A hefty grain bill and use of roasted malts impart both a full body and complex flavors. Early addition of Hallertauer and Tettnang add a non-distinct spice and bring dryness to its chocolatey finish.'),
		(40, 'No One Likes Us, We Don’t Care', 'IPA - American', 5, 6.2, 'https://assets.untappd.com/photos/2022_09_20/23ea998dfb8febd4574ec2a8349990ae_640x640.jpg', 'Dry hoppped with Vic Secret and Equinox.'),
		(40, 'Yin Yang', 'Stout - Oatmeal', 5, 7.1, 'https://assets.untappd.com/photos/2020_01_09/c793762395b82f9b56c0549e22508566_640x640.jpg', 'something you would be into for sure'),
		(40, 'Bubba''s Tea Bag', 'Pale Ale - American', 5, 6.5, 'https://assets.untappd.com/photos/2019_09_15/bb8db66760e244180da715a68ca4d3b6_640x640.jpg', 'Ale infused with Green Tea'),
		(41, 'Pomegranate Wheat', 'Fruit Beer', 5, 4.6, 'https://assets.untappd.com/photos/2022_11_24/4e25833ad900f36e46b85afdd738ae46_640x640.jpg', 'A sweet, golden-hued wheat beer brewed with caramel malts and honey and infused with pomegranate.'),
		(41, 'Missionary Impossible', 'IPA - American', 6, 6.5, 'https://assets.untappd.com/photos/2020_08_15/90241697e243da2c0959484010aa9af7_640x640.jpg', 'Our house IPA is brewed with Chinook, Galena, Mosaic & Centennial hops for a big citrus aroma. Flaked oats give this beer a smooth, soft mouthfeel & a pleasant, lingering finish.'),
		(41, 'Le Pétomane', 'Farmhouse Ale - Saison', 6, 6.3, 'https://assets.untappd.com/photos/2021_08_24/48af619eb3065202c62dd48e6b1c3d44_640x640.jpg', 'A traditional dry farmhouse style ale brewed with black pepper and coriander. Seasonal release.'),
		(42, 'PILSNER', 'German Pilsner / Lager', 4, 5.6, 'https://craftpeak-cooler-images.imgix.net/double-nickel-brewing-co/DOUB-Pilsner-Shop-Photo_Artboard-11.jpg?auto=compress%2Cformat&fit=crop&h=600&ixlib=php-3.3.0&w=600&wpsize=tile_strict&s=a57dcb6dd9c0537547ed2591ecf39303', 'A classically styled clean and crisp option for the lite beer drinker and beer geek alike. Our modern take on a traditional German pilsner.'),
		(42, 'SESSION IPA', 'IPA / Session IPA', 4, 4.7, 'https://craftpeak-cooler-images.imgix.net/double-nickel-brewing-co/DOUB-Session-store-Photo_Artboard-11-1.jpg?auto=compress%2Cformat&fit=crop&h=600&ixlib=php-3.3.0&w=600&wpsize=tile_strict&s=8f3cc5f986eccf3b422e585083287288', 'At a lower ABV, this India pale ale is designed to be enjoyed by all. It’s subtle malt character is highlighted with a hop bill featuring nugget, cascade, citra and simcoe'),
		(42, 'MARBLED RYE', 'Rye / Smokey Rye', 4, 8, 'https://craftpeak-cooler-images.imgix.net/double-nickel-brewing-co/DOUB-Marbled-Rye-Archive-Photo-01.jpg?auto=compress%2Cformat&fit=crop&h=600&ixlib=php-3.3.0&w=600&wpsize=tile_strict&s=8120a81492b009bdce07294f289bcdfc', 'Smokey and sweet, one of Drews ABSOLUTE Favs!')





		;


/***********************************************************************************************************
 Populating time
***********************************************************************************************************/
INSERT INTO public.time(brewery_id, day, open_time, close_time, open) VALUES
	(1, 0, 8, 11, true),
	(1, 1, 8, 11, true),
	(1, 2, 8, 11, true),
	(1, 3, 8, 11, true),
	(1, 4, 8, 11, true),
	(1, 5, 8, 11, true),
	(1, 6, 8, 11, false),
	(2, 0, 9, 11, false),
    (2, 1, 9, 11, false),
    (2, 2, 9, 11, true),
    (2, 3, 9, 11, true),
    (2, 4, 9, 11, true),
    (2, 5, 9, 11, true),
    (2, 6, 9, 11, false),
    (3, 0, 5, 12, false),
    (3, 1, 5, 12, false),
    (3, 2, 5, 12, false),
    (3, 3, 5, 12, false),
    (3, 4, 5, 12, true),
    (3, 5, 5, 12, true),
    (3, 6, 5, 12, true),
    (4, 0, 8, 11, true),
    (4, 1, 8, 11, true),
    (4, 2, 8, 11, true),
    (4, 3, 8, 11, true),
    (4, 4, 8, 11, true),
    (4, 5, 8, 11, true),
    (4, 6, 8, 11, false),
    (5, 0, 9, 11, false),
    (5, 1, 9, 11, false),
    (5, 2, 9, 11, true),
    (5, 3, 9, 11, true),
    (5, 4, 9, 11, true),
    (5, 5, 9, 11, true),
    (5, 6, 9, 11, false),
    (6, 0, 5, 12, false),
    (6, 1, 5, 12, false),
    (6, 2, 5, 12, false),
    (6, 3, 5, 12, false),
    (6, 4, 5, 12, true),
    (6, 5, 5, 12, true),
    (6, 6, 5, 12, true),
    (7, 0, 8, 11, true),
    (7, 1, 8, 11, true),
    (7, 2, 8, 11, true),
    (7, 3, 8, 11, true),
    (7, 4, 8, 11, true),
    (7, 5, 8, 11, true),
    (7, 6, 8, 11, false),
    (8, 0, 8, 11, true),
    (8, 1, 8, 11, true),
    (8, 2, 8, 11, true),
    (8, 3, 8, 11, true),
    (8, 4, 8, 11, true),
    (8, 5, 8, 11, true),
    (8, 6, 8, 11, false);



/***********************************************************************************************************
 Populating beer review
***********************************************************************************************************/
INSERT INTO public.beer_reviews(beer_id, user_id, brewery_id, rating, review) VALUES
	(2, 3, 1, 4, 'Pours a clear brown color. 1/2 inch head of an off-tan color. Great retention and great lacing. Smells of hint of smoke, raisin, sweet malt, and a hint of hop. Fits the style of a Munich Dunkel Lager. Mouth feel is smooth and clean, with an average carbonation level. Tastes of raisin, sweet malt, hint of hop. yeast, hint of wheat, hint of roasted malt, and slight spice. Overall, good appearance and feel, but the name implies smoke and it is almost indiscernible. Otherwise a good blend of flavors.'),
	(8, 3, 2, 3, 'Can from the Packie.Lightly hazy lemon in color with a small bubbly white head that slowly recedes. Juicy citrus and topical fruits with bits of earth and grass. Light bready crackery maltiness, bubbly seltzer. Not bad.'),
	(12, 1, 3, 3,'Hazy bronze off white head. Smells of passion fruit and pineapple. This beer is on the sweet side. It does have a bite but the carbonation is low and it doesn''t cut through. I think it is OK.'),
	(16,4, 4, 4,'Hazy bronze off white head. Smells of passion fruit and pineapple. This beer is on the sweet side. It does have a bite but the carbonation is low and it doesn''t cut through. I think it is OK.'),
	(23, 3, 5, 3,'Poured from a pint can into a snifter glass. Full off-white head with an amber colored body of beer. The aroma of citrus and berries were prevalent on the nose. First sip was of grapefruit, apricots and raspberries, with a nice mildly bitter finish provided by the combination of Amarillo and Citra hops. Another fine DIPA from Housatonic.'),
	(27, 5, 6, 4, 'Interesting color and smell. Not typical. Feels like it would be best to drink outdoors. A tad more bitter than I prefer but overall good IPA.'),
	(30, 4, 7, 2, 'Taste: A lot of biscuity malt up front. Balanced out by hops - mostly orange peel and citrus - but not as hoppy as I would expect. Feel: Nice medium body, decent carbonation, and very smooth. Overall: A decent brew, but I had high expectations for such a fresh beer, and it didn''t quite live up to them.'),
	(32, 1, 8, 3, 'Overall considerably Good. Coffee Flavor defiantly comes through in the tasting notes. The beer itself is somewhat bland, more suited towards a larger Market.'),
	(38, 4, 9, 5, 'Amber in color, didn''t seem overcarbonated to me. Powerful aromas of citrus fruit, which was also present in the taste, with some maltiness and a decent bitterness. Fairly light in body but OK. Kind of an unorthodox WCIPA due to the Citra, which brings lots of fruity character.'),
	(39, 5, 10, 5, 'It poured a hazy copper colar with a white head that leaves nice lasing on the glass. It smells and taste of tropical fruit ( mango mostly to me). It has a nice body easy to drink. A good solid IPA to me.'),
	(45, 3, 11, 3, 'Their naming system is confusing. Two versions on the night howler. Vanilla and Coconut version was stellar.'),
	(47, 5, 12, 5, 'Excellent pilsner, well done for this brewer at Dock St. South. Clean clear look and taste with extra hopping appreciated. Really easy to drink and great with pizza!'),
	(52, 4, 13, 4, 'Whirlpooled with Sabro and Mosaic hops after the boil, Tiger Smile is a tropical juice coconut explosion with a slight bit of minty bitterness.  It will put a smile on your face.'),
	(53, 1, 14, 2, 'Love the name wanted to love the beer couldn’t quite get there. Taste is all over the map and kind of boozy. Wish I had more to say but really that is about all for this one'),
	(57, 3, 15, 3, 'Deep orange body. Smells of pine resin and tropical fruit sweetness. Tastes of tropical fruit briefly. Toasty malt with some caramel sweetness. Pine and a resiny bitterness in the back end. Dries out and leaves a long bitter aftertaste. Medium body. Good.'),
	(61, 4, 16, 1, 'Meh, I don''t wanna have to go out to drink it...'),
	(63, 3, 17, 4, 'Cloudy golden with white lacing. Smells of hop spice, light booze, citrus, light rind. Tastes of papaya, citrus, rind, grass, some bitterness. Not crazy thick. Tastes a lot like Money.'),
	(65, 4, 18, 5, 'Phenomenal stuff they''ve created. Absolutely checks all my boxes for an IPA and a clearly different take than many other NEIPAs I enjoy. Super refreshing.'),
	(68, 1, 19, 3, 'Good beer for anyone that is dieting! It is not as good as the regular lager but better than most other light beers I have tried except Yuengling. The taste is fine and the appearace is fine but very pale compared to Yuengling.This beer needs to be very cold for my taste but that is the way I prefer most beers'),
	(71, 5, 20, 5, 'The taste begins with a wave of very pleasing and natural flavors of peanut butter and marshmallows. This carries the taste, throughout. Midway through, the alcohol makes its presence known, with a warm and mellow note. Late in the taste, there is just a faint kiss of herbal hops, balancing out the sweetness. Finishes with a mild, lingering note of marshmallows.'),
	(75, 1, 21, 4, ' First comes dark chocolate followed by roasted malts in the middle where they mix with cacao notes and vanilla turning sweet. The sweetness continues into the rear of the palate mixing with coconut but is slightly blunted by some almond nuttiness and more cacao and dark bitter chocolate.'),
	(78, 3, 22, 2, 'Tart, not excessively sour. Pale slightly hazy pink, moderate head settling quickly to a ring, no lace. Anonymously fruity. Ordinary fruity summer fare.'),
	(80, 4, 23, 1, 'Mild barley and corn that turns to a slight metal twang as a straw, honey and a mix of earth and mossy hops round out the experience. Kind of upset about the middle of the beer, but the rest does make up for it.'),
	(83, 1, 24, 3, 'Was definitely better on tap at the venue than from the can. Less sour more sweet from the can, still good though'),
	(88, 3, 25, 3, 'Somewhere between straw and amber; head subsides quickly with not much retention, clarity is slightly cloudy.'),
	(90, 1, 26, 5, 'An unflitered double IPA, this one is not bitter. Extremely good - a bit more hoppy than most DIPAs this beer has a well balanced flavor profile and is worth drinking.'),
	(93, 5, 27, 4, 'Poured from can into tulip glass. Poured a clear honey blonde with thick fluffy white head. Heavy citrus notes on the nose. Taste followed the nose with a pleasant tart. Medium bodied. Very enjoyable beer. I love sours and I love IPA. They seem to have found the best of both.'),
	(96, 3, 28, 3, 'Sweet, freshly picked Nelson hoppy nose on this one! Ha! Taste follows with a dank, white wine grape, grapefruit bitter bite on the swallow. The depth and feel are decent for a single, but would be better if it was a little softer on the palate. Still an intense Nelson IPA that is really good!'),
	(99, 1, 29, 5, 'Nice summer beer with big LIME flavor'),
	(103, 4, 30, 1, 'Almost tastes like it was originally intended to be a porter, but got infected. Almost no sourness on the nose, but decent sour flavor. Not sure what would improve it but it''s not very good the way it is.'),
	(105, 3, 31, 3, 'Very smooth. Medium body, easy drinking with light carbonation. Finishes dry and doesn''t linger too much on the tongue. A very drinkable beer.'),
	(104, 5, 32, 2, 'Pours near flat, little to no head or lacing, basic and non remarkable hop forward flavour, just ok, def. Not a choice at price point!'),
	(1, 3, 1, 5, 'So good.'),
	(1, 4, 1, 5, 'Amazing!'),
	(1, 5, 1, 5, 'Sorprendente. Sicuramente tornerò'),
	(1, 6, 1, 5, 'pretty good, can''t lie'),
	(1, 7, 1, 5, 'can''t wait to come back!'),
	(6, 3, 1, 5, 'So good.'),
	(6, 4, 1, 5, 'Amazing!'),
	(6, 5, 1, 5, 'Sorprendente. Sicuramente tornerò'),
	(6, 6, 1, 5, 'pretty good, can''t lie'),
	(6, 7, 1, 5, 'can''t wait to come back!'),
	(2, 3, 1, 4, 'just wow'),
	(2, 4, 1, 5, 'Oh yea. thats the stuff fr'),
	(2, 5, 1, 5, 'I''m just amazed a beer can taste like that!'),
	(3, 3, 1, 4, 'Così buono! Non riesco a credere quanto fosse bello'),
	(3, 4, 1, 4, 'Ho portato mia moglie qui e lei adorava la bevanda'),
	(3, 5, 1, 4, 'Fantastico!'),
	(3, 6, 1, 5, 'really good tbh'),
	(4, 3, 1, 4, 'Così buono! Non riesco a credere quanto fosse bello'),
	(4, 4, 1, 4, 'Ho portato mia moglie qui e lei adorava la bevanda'),
	(4, 5, 1, 4, 'Fantastico!'),
	(4, 6, 1, 5, 'really good tbh'),
	(5, 3, 1, 4, 'Così buono! Non riesco a credere quanto fosse bello'),
	(5, 4, 1, 4, 'Ho portato mia moglie qui e lei adorava la bevanda'),
	(5, 5, 1, 4, 'Fantastico!'),
	(5, 6, 1, 5, 'really good tbh'),
	(7, 3, 2, 4, 'Così buono! Non riesco a credere quanto fosse bello'),
	(7, 4, 2, 4, 'Ho portato mia moglie qui e lei adorava la bevanda'),
	(7, 5, 2, 4, 'Fantastico!'),
	(7, 6, 2, 5, 'really good tbh'),
	(8, 3, 2, 3, 'Così buono! Non riesco a credere quanto fosse bello'),
	(8, 4, 2, 4, 'Ho portato mia moglie qui e lei adorava la bevanda'),
	(8, 5, 2, 4, 'Fantastico!'),
	(8, 6, 2, 5, 'really good tbh'),
	(9, 3, 2, 4, 'Quite the beverage'),
	(9, 4, 2, 3, 'Ho portato mia moglie qui e lei adorava la bevanda'),
	(9, 5, 2, 4, 'Fantastico!'),
	(9, 6, 2, 5, 'really good tbh'),
	(10, 3, 2, 3, 'Così buono! Non riesco a credere quanto fosse bello'),
	(10, 4, 2, 4, 'Ho portato mia moglie qui e lei adorava la bevanda'),
	(10, 5, 2, 4, 'Fantastico!'),
	(10, 6, 2, 5, 'really good tbh'),
	(11, 3, 3, 4, 'Quite the beverage'),
	(11, 4, 3, 3, 'Ho portato mia moglie qui e lei adorava la bevanda'),
	(11, 5, 3, 4, 'Fantastico!'),
	(11, 6, 3, 5, 'really good tbh'),
	(11, 3, 3, 4, 'Quite the beverage'),
	(11, 4, 3, 3, 'Ho portato mia moglie qui e lei adorava la bevanda'),
	(11, 5, 3, 4, 'Fantastico!'),
	(11, 6, 3, 5, 'really good tbh'),
	(15, 3, 4, 4, 'Quite the beverage'),
	(15, 4, 4, 3, 'Ho portato mia moglie qui e lei adorava la bevanda'),
	(15, 5, 4, 1, 'Fantastico!'),
	(15, 6, 4, 5, 'really good tbh'),
	(19, 1, 5, 5, 'This beer was so good I had to bring my wife here!'),
	(19, 3, 5, 4, 'really good tbh'),
	(19, 4, 5, 4, 'Bought this for 83p. Hard to knock it at that price. A bit on the malty side but quite drinkable'),
	(19, 5, 5, 4, 'Fantastico! Dovrò portare mia madre qui per provare questa birra'),
	(19, 7, 5, 5, 'I was genuinely impressed'),
	(19, 10, 5, 5, 'this beer was OUTSTANDING'),
	(20, 1, 5, 5, 'Pours a clear brown color. 1/2 inch head of an off-tan color. Great retention and great lacing. Smells of hint of smoke, raisin, sweet malt, and a hint of hop. Fits the style of a Munich Dunkel Lager. Mouth feel is smooth and clean, with an average carbonation level. Tastes of raisin, sweet malt, hint of hop. yeast, hint of wheat, hint of roasted malt, and slight spice. Overall, good appearance and feel, but the name implies smoke and it is almost indiscernible. Otherwise a good blend of flavors.'),
	(20, 3, 5, 4, 'really good tbh'),
	(20, 4, 5, 4, 'Bought this for 83p. Hard to knock it at that price. A bit on the malty side but quite drinkable'),
	(20, 5, 5, 4, 'Fantastico! Dovrò portare mia madre qui per provare questa birra'),
	(20, 7, 5, 5, 'I was genuinely impressed'),
	(20, 10, 5, 5, 'this beer was OUTSTANDING'),
	(21, 10, 5, 5, 'Very delicous!'),
	(21, 7, 5, 4, 'really good tbh'),
	(21, 5, 5, 4, 'Molto bene. voglio di più'),
	(21, 4, 5, 3, 'I mean it was alright I guess'),
	(21, 3, 5, 5, 'reeeeally good'),
	(21, 1, 5, 5, 'this beer was AMAZING'),		
	(46, 10, 13, 5, 'Very delicous!'),
	(46, 7, 13, 4, 'really good tbh'),
	(46, 5, 13, 5, 'birra fantastica'),
	(46, 4, 13, 3, 'I mean it was alright I guess'),
	(46, 3, 13, 5, 'reeeeally good'),
	(46, 1, 13, 2, 'wasn''t feeling it AT ALL'),	
	(47, 10, 13, 5, 'Very delicous!'),
	(47, 7, 13, 3, 'i mean... it was ok. not bad. what I buy it again? Uhhh, probably not'),
	(47, 5, 13, 4, 'Molto bene. voglio di più'),
	(47, 4, 13, 3, 'I mean it was alright I guess'),
	(47, 3, 13, 5, 'reeeeally good'),
	(47, 1, 13, 5, 'this beer was AMAZING'),
	(73, 10, 22, 5, 'Very delicous!'),
	(73, 7, 22, 3, 'i mean... it was ok. not bad. what I buy it again? Uhhh, probably not'),
	(73, 5, 22, 4, 'Molto bene. voglio di più'),
	(73, 4, 22, 3, 'I mean it was alright I guess'),
	(73, 3, 22, 5, 'reeeeally good'),
	(73, 1, 22, 5, 'this beer was AMAZING'),
	(123, 10, 38, 5, 'Very delicous!'),
	(123, 7, 38, 3, 'i mean... it was ok. not bad. what I buy it again? Uhhh, probably not'),
	(123, 5, 38, 4, 'Molto bene. voglio di più'),
	(123, 4, 38, 3, 'I mean it was alright I guess'),
	(123, 3, 38, 5, 'reeeeally good'),
	(123, 1, 38, 5, 'this beer was AMAZING'),	
	(124, 10, 38, 5, 'Very delicous!'),
	(124, 7, 38, 3, 'i mean... it was ok. not bad. what I buy it again? Uhhh, probably not'),
	(124, 5, 38, 4, 'Molto bene. voglio di più'),
	(124, 4, 38, 3, 'I mean it was alright I guess'),
	(124, 3, 38, 5, 'reeeeally good'),
	(124, 1, 38, 5, 'this beer was AMAZING')	
	;




;


COMMIT;

GRANT ALL
ON ALL TABLES IN SCHEMA public
TO final_capstone_owner;

GRANT ALL
ON ALL SEQUENCES IN SCHEMA public
TO final_capstone_owner;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO final_capstone_appuser;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO final_capstone_appuser;