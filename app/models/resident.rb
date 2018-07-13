class Resident < ActiveRecord::Base

  belongs_to :recipient

  scope :young_people,  {:conditions => "age < 18"}
  scope :adults,  {:conditions => "age > 17"}

  scope :zero_to_fourteen,  {:conditions => "age < 15"}
  scope :fifteen_to_thirty,  {:conditions => "age > 14 AND age < 31"}
  scope :thirtyone_to_sixtyfour,  {:conditions => "age > 30 AND age < 65"}
  scope :sixtyfive_plus,  {:conditions => "age > 64"}
  scope :with_no_age,  {:conditions => "age IS NULL"}

  scope :males,  {:conditions => "gender = 'M'"}
  scope :females,  {:conditions => "gender = 'F'"}
  scope :aboriginals,  {:conditions => "aboriginal = TRUE"}
  scope :recent_immigrants,  {:conditions => "recent_immigrant = TRUE"}
  scope :not_aboriginal_or_recent_immigrants,  {:conditions => "recent_immigrant = FALSE AND aboriginal = FALSE"}
  scope :disabled_people,  {:conditions => "disabled = TRUE"}
  scope :not_parents,  {:conditions => "category <> 1 AND category <> 2"}
  scope :parents,  {:conditions => "category = 1"}
  scope :children,  {:conditions => "category = 2"}
  scope :girls,  {:conditions => "category = 2 AND gender = 'F'"}
  scope :boys,  {:conditions => "category = 2 AND gender = 'M'"}
  scope :the_recipient,  {:conditions => "is_recipient = true"}
  scope :the_spouse, {:conditions => "is_recipient = false AND category = 1"}  # is not the recipient, but is a parent
  scope :other_adults, {:conditions => "category <> 1 AND category <> 2 AND is_recipient = false"} # everyone except parents and children


  GENDERS = { 'M' => 'Male', 'F' => 'Female'}

  PARENT = 1
  CHILD = 2
  RELATIVE = 3
  ROOMMATE = 4
  OTHER = 5
  ADULT = 6


  CATEGORIES = {PARENT => 'Parent', CHILD => 'Child', ADULT => 'Adult', RELATIVE => 'Relative',
                ROOMMATE => 'Roommate', OTHER => 'Other'}



end
