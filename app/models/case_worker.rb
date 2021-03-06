class CaseWorker < ActiveRecord::Base

  has_many :recipients
  belongs_to :organization

  scope :name_like,  -> (search_term) {where("last_name LIKE ?", "%#{search_term}%")}

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  # build a list of case workers to be displayed in a selectable list (including a blank entry - "none")
  def self.items_for_select
    CaseWorker.all.map { |it| ["#{it.full_name} - #{it.organization.andand.org_short_name}", it.id]}.unshift(['none', nil])
  end

end
