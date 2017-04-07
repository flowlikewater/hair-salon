require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/client")
require("./lib/stylist")
require('pg')

DB = PG.connect({:dbname => "hair_salon"})

get("/") do
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

get("/stylists") do
  @stylists = Stylist.all()
  erb(:stylists)
end

get("/clients") do
  @clients = Client.all()
  erb(:clients)
end

post("/stylists") do
  name = params.fetch("name")
  experience = params.fetch('experience')
  stylist = Stylist.new({:name => name, :experience => experience})
  stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end

get("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @clients = @stylist.clients()
  erb(:stylist)
end

post("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  name = params.fetch('name')
  stylist_id = @stylist.id().to_i()
  client = Client.new({:name => name, :stylist_id => stylist_id})
  client.save()
  @clients = @stylist.clients()
  erb(:stylist)
end

delete("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.delete()
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

get("/clients/:id") do
  @client = Client.find(params.fetch("id").to_i())
  erb(:client)
end

delete("/clients/:id") do
  @client = Client.find(params.fetch('id').to_i())
  stylist_id = @client.stylist_id().to_i()
  @client.delete()
  @stylist = Stylist.find(stylist_id)
  @clients = @stylist.clients()
  erb(:stylist)
end

patch("/clients/:id") do
  name = params.fetch("name")
  @client = Client.find(params.fetch("id").to_i())
  @client.update({:name => name})
  erb(:client)
end

patch("/stylists/:id") do
  name = params.fetch("name")
  experience = params.fetch("experience")
  @stylist = Stylist.find(params.fetch("id").to_i())
  @clients = @stylist.clients()
  @stylist.update({:name => name, :experience => experience})
  erb(:stylist)
end
