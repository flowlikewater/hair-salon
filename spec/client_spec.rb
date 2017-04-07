require("spec_helper")

  describe(Client) do

    describe("#initialize") do
      it("is initialized with a name") do
        client = Client.new({:name => "Brad Pitt", :stylist_id => '1'})
        expect(client).to(be_an_instance_of(Client))
      end
    end

    describe(".all") do
      it('returns an empty array at first') do
        expect(Client.all()).to(eq([]))
      end
    end

    describe('.find') do
      it('returns a client by id no.') do
        client = Client.new({:name => "Brad Pitt", :stylist_id => '1'})
        client.save()
        client2 = Client.new({:name => "Angelina Jolie", :stylist_id => '1'})
        client2.save()
        expect(Client.find(client2.id())).to(eq(client2))
      end
    end

    describe("#==") do
      it("is the same client if it has the same name, experience, and id") do
        client = Client.new({:name => "Brad Pitt", :stylist_id => '1'})
        client2 = Client.new({:name => "Brad Pitt", :stylist_id => '1'})
        expect(client).to(eq(client2))
      end
    end

    describe("#update") do
      it("lets you update clients in the database") do
        client = Client.new({:name => "Brad Pitt", :stylist_id => '1'})
        client.save()
        client.update({:name => "Pitbull"})
        expect(client.name()).to(eq("Pitbull"))
      end
    end

    describe("#delete") do
      it("lets you delete an client from the database") do
        client = Client.new({:name => "Brad Pitt", :stylist_id => '1'})
        client.save()
        client2 = Client.new({:name => "Pitbull", :stylist_id => 2})
        client2.save()
        client2.delete()
        expect(Client.all()).to(eq([client]))
      end
    end

end
