require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "should raise error if incorrect input is passed" do
      items = [Item.new("foo", "invalid", 0)]
      expect { GildedRose.new(items).update_quality() }.to raise_error(StandardError)
    end

    context "normal product" do
      it "decreases quality and sell in by 1" do
        items = [Item.new("Cheese Cake", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Cheese Cake, 9, 9"
      end

      it "decreases quality by 2 when sell in value reaches 0" do
        items = [Item.new("Cheese Cake", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Cheese Cake, -1, 8"
      end

      it "checks for quality to never be less than 0" do
        items = [Item.new("Cheese Cake", 10, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Cheese Cake, 9, 0"
      end
    end

    context "Aged Brie" do
      it "increases quality and decreases sell in by 1" do
        items = [Item.new("Aged Brie", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Aged Brie, 9, 11"
      end

      it "increases quality by 2 when sell in value reaches 0" do
        items = [Item.new("Aged Brie", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Aged Brie, -1, 12"
      end

      it "checks for quality to never be more than 50" do
        items = [Item.new("Aged Brie", 10, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Aged Brie, 9, 50"
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it "never changes it's sell in value" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Sulfuras, Hand of Ragnaros, 10, 80"
      end

      it "never changes it's quality" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Sulfuras, Hand of Ragnaros, 0, 80"
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert" do
      context "sell in value is greater than 10" do
        it "increases quality and decreases sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 10)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 19, 11"
        end

        it "checks for quality to never be more than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 50)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 19, 50"
        end
      end

      context "sell in value is less than 11 and greater than 5" do
        it "increases quality by 2 and decreases sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 9, 12"
        end

        it "checks for quality to never be more than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 9, 50"
        end
      end

      context "sell in value is less than 6 and greater than 0" do
        it "increases quality by 3 and decreases sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 4, 13"
        end

        it "checks for quality to never be more than 50" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 50)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 4, 50"
        end
      end

      context "sell in value is 0 or lower" do
        it "sets quality quals to 0 and decreases sell in by 1" do
          items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
          GildedRose.new(items).update_quality()
          expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, -1, 0"
        end
      end
    end

    context "Conjured Mana Cake" do
      it "decreases quality by 2 and sell in by 1" do
        items = [Item.new("Conjured Mana Cake", 10, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Conjured Mana Cake, 9, 8"
      end

      it "decreases quality by 4 when sell in value reaches 0" do
        items = [Item.new("Conjured Mana Cake", 0, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Conjured Mana Cake, -1, 6"
      end

      it "checks for quality to never be less than 0" do
        items = [Item.new("Conjured Mana Cake", 10, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Conjured Mana Cake, 9, 0"
      end
    end
  end

end
