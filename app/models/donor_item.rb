class DonorItem < ActiveRecord::Base
  belongs_to :donor
  belongs_to :item

  validates_presence_of :item_id

  scope :donated_on_a_specific_date, lambda{ |a_date| {:conditions => ["donated_on = ?", a_date.beginning_of_day.to_s(:db)]}} # .utc.strftime("%Y-%m-%d")
  scope :donated_on_is_null, {:conditions => ["donated_on IS NULL"]}
  scope :ordered_by_item_category, {:include => :item, :order => "items.category_id ASC"}
end
