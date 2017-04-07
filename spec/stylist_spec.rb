require("spec_helper")

  describe(Stylist) do

    describe("#initialize") do
      it("is initialized with a name") do
        stylist = Stylist.new({:name => "Vidal Sassoon", :experience => 10})
        expect(stylist).to(be_an_instance_of(Stylist))
      end
    end

    describe(".all") do
      it('returns an empty array at first') do
        expect(Stylist.all()).to(eq([]))
      end
    end

    describe('.find') do
      it('returns a stylist by id no.') do
        stylist = Stylist.new({:name => "Vidal Sassoon", :experience => 10})
        stylist.save()
        stylist2 = Stylist.new({:name => "Trevor Sorbie", :experience => 20})
        stylist2.save()
        expect(Stylist.find(stylist2.id())).to(eq(stylist2))
      end
    end

    describe("#==") do
      it("is the same stylist if it has the same name, experience, and id") do
        stylist = Stylist.new({:name => "Vidal Sassoon", :experience => 10})
        stylist2 = Stylist.new({:name => "Trevor Sorbie", :experience => 20})
        expect(stylist).to(eq(stylist2))
      end
    end

    describe("#update") do
      it("lets you update stylists in the database") do
        stylist = Stylist.new({:name => "Vidal Sassoon", :experience => 10})
        stylist.save()
        stylist.update({:name => "Pitbull"})
        expect(stylist.name()).to(eq("Pitbull"))
      end
    end

    describe("#delete") do
      it("lets you delete an stylist from the database") do
        stylist = Stylist.new({:name => "Vidal Sassoon", :experience => 10})
        stylist.save()
        stylist2 = Stylist.new({:name => "Trevor Sorbie", :experience => 20})
        stylist2.save()
        stylist2.delete()
        expect(Stylist.all()).to(eq([stylist]))
      end
    end

end
