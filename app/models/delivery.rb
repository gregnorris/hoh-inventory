class Delivery < ActiveRecord::Base

  has_many :delivered_items, :foreign_key => :delivery_id#, :dependent => :destroy
  belongs_to :recipient
  has_many :daily_deliveries#, :dependent => :destroy

  accepts_nested_attributes_for :delivered_items, :allow_destroy => true, :reject_if => proc { |attributes| attributes.all? {|k,v| v.blank? || v == '0'} }

  scope :in_order_of_delivery, -> {order('scheduled_delivery_time ASC')}

  scope :first_name_like,  -> (search_term) {includes(:recipient).where("recipients.first_name LIKE ?", "#{search_term}%") unless search_term.blank?}
  scope :last_name_like,  -> (search_term) {includes(:recipient).where("recipients.last_name LIKE ?", "#{search_term}%") unless search_term.blank?}
  scope :address_like,  -> (search_term) {includes(:recipient).where("recipients.street_1 LIKE ?", "%#{search_term}%") unless search_term.blank?}
  scope :health_number_like, -> (search_term) {includes(:recipient).where("recipients.health_care_number = ?", "#{search_term}") unless search_term.blank?}

  scope :for_delivery_date_range, -> (date_start, date_end) {where("scheduled_delivery_time BETWEEN ? and ?", Date.parse(date_start).beginning_of_day.to_s(:db), Date.parse(date_end).end_of_day.to_s(:db)) unless (date_start.blank? || date_end.blank?)}
  scope :with_state, -> (search_term) {where("state = ?", search_term) unless search_term == ''}
  scope :is_pending, -> (search_term) {where("pending = ?", search_term) unless search_term == ''}
  scope :with_priority, -> (search_term) {where("priority = ?", search_term) unless search_term == ''}

  scope :city_section_is, -> (section) {includes(:recipient).where("recipients.city_section = ?", section) unless section.blank?}

  scope :was_delivered_to, -> {where("state = 2 OR state = 3") }
  scope :not_yet_delivered,  -> {where("state <> 2 AND state <> 3") }

  scope :by_newest_delivery_date,  -> (recipient_id) {where("recipient_id = ?", recipient_id).order('scheduled_delivery_time DESC')}
  scope :by_oldest_uncompleted,  -> {where("state <> 3 AND state <> 4").order('scheduled_delivery_time ASC')}
  scope :for_date, -> (a_date) {where("scheduled_delivery_time BETWEEN ? AND ?", a_date.beginning_of_day.to_s(:db), a_date.end_of_day.to_s(:db)).order('scheduled_delivery_time DESC')}

  ENTERED = 0
  SCHEDULED = 1
  PARTIAL = 2
  COMPLETED = 3
  CANCELLED = 4
  NOT_DONE = 5

  STATES = { SCHEDULED => "Scheduled", ENTERED => "Entered",
             PARTIAL => "Partially Done", NOT_DONE => "Not Done", COMPLETED => "Completed", CANCELLED => "Cancelled"}

  # priority classifications
  CLASS_A = 1
  CLASS_B = 2
  CLASS_C = 3

  PRIORITIES = { CLASS_A => "A", CLASS_B => "B", CLASS_C => "C" }

# NOT used yet (may use later)
#  def total_requested_items
#    self.delivered_items.map { |sum, element| sum + element.number_requested}
#  end

  # string formatted list of items and number
  def items_list
    return self.delivered_items.map{|it| " #{it.andand.item.andand.item_code} [#{it.number_requested}] "}.join("/")
  end

#  def self.total_people_served(from_date, to_date)
#    return total_households_served(from_date, to_date).
#  end

  def self.total_households_served(from_date, to_date)
    return Delivery.for_delivery_date_range(from_date, to_date).was_delivered_to.map{|del| del.recipient}.compact.uniq
  end

  def self.total_households_requesting(from_date, to_date)
    return Delivery.for_delivery_date_range(from_date, to_date).not_yet_delivered.map{|del| del.recipient}.compact.uniq
  end


#
#  def self.total_people_served(from_date, to_date)
#
#  end
#
#  def self.total_people_served(from_date, to_date)
#
#  end

  def has_this_item?(item_id)
    item_id.blank? ? true : self.delivered_items.map(&:item_id).include?(item_id)
  end

end
