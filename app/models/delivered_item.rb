class DeliveredItem < ActiveRecord::Base
  belongs_to :delivery
  belongs_to :item

  validates_presence_of :item_id
  scope :ordered_by_item_category, {:include => :item, :order => "items.category_id ASC"}
  scope :still_to_deliver, :conditions => ["done IS NOT TRUE"]
end
