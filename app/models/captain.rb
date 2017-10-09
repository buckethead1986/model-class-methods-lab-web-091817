require 'pry'
class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    # binding.pry
    self.joins("JOIN boats ON boats.captain_id == captains.id").joins("JOIN boat_classifications ON boat_classifications.boat_id == boats.id").joins("JOIN classifications ON classifications.id == boat_classifications.classification_id").where("classifications.name == 'Catamaran'")
  end

  def self.sailors
    self.joins("JOIN boats ON boats.captain_id == captains.id").joins("JOIN boat_classifications ON boat_classifications.boat_id == boats.id").joins("JOIN classifications ON classifications.id == boat_classifications.classification_id").where("classifications.name == 'Sailboat'").uniq
    # captain join with boats join with boat classification join with classification select for sailboats
  end

  def self.talented_seamen
    # self.joins("JOIN boats ON boats.captain_id == captains.id").joins("JOIN boat_classifications ON boat_classifications.boat_id == boats.id").joins("JOIN classifications ON classifications.id == boat_classifications.classification_id").where("classifications.name == 'Sailboat' OR classifications.name =='Motorboat'").group("classifications.name").order("classifications.name DESC")
    joins(:classifications).where("classifications.name == 'Sailboat' OR classifications.name =='Motorboat'").group("classifications.name").order("classifications.name DESC")
  end

  def self.non_sailors
    non_sailor_ids = self.sailors.collect {|sailor| sailor.id} #use self.sailors method, select all id's for sailors, and then
    self.where.not(id: non_sailor_ids) #use where.not the iud's are equal to those in that array.
    # self.joins("JOIN boats ON boats.captain_id == captains.id").joins("JOIN boat_classifications ON boat_classifications.boat_id == boats.id").joins("JOIN classifications ON classifications.id == boat_classifications.classification_id")
  end
end
