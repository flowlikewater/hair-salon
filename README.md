Step 1: Cloning project to machine

1. Enter terminal
2. Type the following - git clone https://github.com/kevinch0/hair-salon.git
3. Type the following - cd hair-salon
4. Run bundle by typing the following - bundle

Step 2: Database setup instructions using psql:

1. CREATE DATABASE hair_salon;
2. \c hair_salon;
3. CREATE TABLE clients (id serial PRIMARY KEY, name varchar, stylist_id int);
4. CREATE TABLE stylists (id serial PRIMARY KEY, name varchar, experience int);

Step 3: Deploying app on Local Host

1. Enter terminal, enter folder hair-salon
2. Type the following - ruby app.rb
