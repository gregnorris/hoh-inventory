class Resident < ActiveRecord::Base

  belongs_to :recipient

  scope :young_people,  -> {where("age < 18")}
  scope :adults,  -> {where("age > 17")}

  scope :zero_to_fourteen,  -> {where("age < 15")}
  scope :fifteen_to_thirty,  -> {where("age > 14 AND age < 31")}
  scope :thirtyone_to_sixtyfour,  -> {where("age > 30 AND age < 65")}
  scope :sixtyfive_plus,  -> {where("age > 64")}
  scope :with_no_age,  -> {where("age IS NULL")}

  scope :males,  -> {where("gender = 'M'")}
  scope :females,  -> {where("gender = 'F'")}
  scope :aboriginals,  -> {where("aboriginal = TRUE")}
  scope :recent_immigrants,  -> {where("recent_immigrant = TRUE")}
  scope :not_aboriginal_or_recent_immigrants,  -> {where("recent_immigrant = FALSE AND aboriginal = FALSE")}
  scope :disabled_people,  -> {where("disabled = TRUE")}
  scope :not_parents,  -> {where("category <> 1 AND category <> 2")}
  scope :parents,  -> {where("category = 1")}
  scope :children,  -> {where("category = 2")}
  scope :girls,  -> {where("category = 2 AND gender = 'F'")}
  scope :boys,  -> {where("category = 2 AND gender = 'M'")}
  scope :the_recipient,  -> {where("is_recipient = true")}
  scope :the_spouse, -> {where("is_recipient = false AND category = 1")}  # is not the recipient, but is a parent
  scope :other_adults, -> {where("category <> 1 AND category <> 2 AND is_recipient = false")} # everyone except parents and children


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
