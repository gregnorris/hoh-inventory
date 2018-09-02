class PickedupItem < ActiveRecord::Base
  belongs_to :donor_pickup
  belongs_to :item

  validates_presence_of :item_id

  scope :that_were_donated,  -> {where("number_donated IS NOT NULL AND number_donated > 0")}
  scope :that_were_offered,  -> {where("number_offered IS NOT NULL AND number_offered > 0")}

  scope :is_this_item,  -> (the_item_id) {where("item_id = ?", the_item_id)}
  scope :ordered_by_item_category, -> {includes(:item).order("items.category_id ASC")}
  scope :still_to_pickup, -> {where("done IS NOT TRUE")}


  PET_HAIR = 1
  NEEDS_CLEANING = 2
  NEEDS_REPAIR = 3
  TOO_HEAVY = 4
  WORN_OUT = 5


  DECLINED_REASONS = { PET_HAIR => "Pet's Hair", NEEDS_CLEANING => "Needs Cleaning",
                       NEEDS_REPAIR => "Needs Repair", TOO_HEAVY => "Quite Heavy",
                       WORN_OUT => "Worn-out" }

end
