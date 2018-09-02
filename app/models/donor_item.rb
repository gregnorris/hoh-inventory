class DonorItem < ActiveRecord::Base
  belongs_to :donor
  belongs_to :item

  validates_presence_of :item_id

  scope :donated_on_a_specific_date, -> (a_date) {where("donated_on = ?", a_date.beginning_of_day.to_s(:db))} # .utc.strftime("%Y-%m-%d")
  scope :donated_on_is_null, -> {where("donated_on IS NULL")}
  scope :ordered_by_item_category, -> {includes(:item).order("items.category_id ASC")}
end
