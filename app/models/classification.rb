class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    # binding.pry

    longest_id = self.joins("JOIN boat_classifications ON classifications.id == boat_classifications.classification_id").joins("JOIN boats ON boats.id == boat_classifications.boat_id").order("boats.length DESC LIMIT 1").pluck(:boat_id)
    boat = Boat.find_by(id: longest_id[0])
    boat.classifications
  end
end
