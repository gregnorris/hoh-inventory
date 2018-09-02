class DeliveredItem < ActiveRecord::Base
  belongs_to :delivery
  belongs_to :item

  validates_presence_of :item_id
  scope :ordered_by_item_category, -> {includes(:item).order("items.category_id ASC")}
  scope :still_to_deliver, -> {where("done IS NOT TRUE")}
end
