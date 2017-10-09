require 'pry'
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # binding.pry
    self.limit(5)
  end

  def self.dinghy
    self.all.where("length < 20")
  end

  def self.ship
    self.all.where("length > 20")
  end

  def self.last_three_alphabetically
    self.all.order(name: :desc).limit(3).order(:name) #select all boats, order by name, descending (swap :name to name: in that case), only get the first 3, then reorder ascending
  end

  def self.without_a_captain
    self.all.where("captain_id IS NULL")
  end

  def self.sailboats
    self.joins("JOIN boat_classifications ON boats.id == boat_classifications.boat_id").joins("JOIN classifications ON boat_classifications.classification_id == classifications.id WHERE classifications.name == 'Sailboat'")
  end

  def self.with_three_classifications
    self.joins("JOIN boat_classifications ON boats.id == boat_classifications.boat_id").group("boats.id").having("COUNT(boat_classifications.classification_id) > 2")
  end

end



# SELECT * FROM boats JOIN boat_classifications ON boats.id == boat_classifications.boat_id JOIN classifications ON boat_classifications.classification_id == classifications.id WHERE classifications.name == "Sailboat"
