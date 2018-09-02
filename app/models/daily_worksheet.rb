class DailyWorksheet < ActiveRecord::Base

  has_many :daily_deliveries, :order => "position", :dependent => :destroy
  accepts_nested_attributes_for :daily_deliveries, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank?} }

  # this works now, I think
  scope :for_date, -> (a_date) {where("worksheet_date = ?", a_date.beginning_of_day.to_s(:db))} # .utc.strftime("%Y-%m-%d")

# not sure why this was done to begin with;  it's been commented-out for a long time.
  #before_save :assign_target
#  def assign_target
#    raise self.changes.inspect
#  end

end
