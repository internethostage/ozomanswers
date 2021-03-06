class User < ActiveRecord::Base
  # has_secure_password does the following:
  # 1- it adds attribute accessors: password and password_confirmation
  # 2- It adds validatation: password must be present on creation
  # 3- If password confirmation is present, it will make sure it's equal to password
  # 4- Password length should be less than or equal to 72 characters
  # 5- It will hash the password using BCrypt and stores the hash digest in the password_digest field
  has_secure_password

  has_many :questions,  dependent: :nullify
  has_many :answers,    dependent: :nullify

  has_many :votes,      dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  has_many :likes, dependent: :destroy
  # we use source option in here because we used the questions earlier. So we are using liked_question instead.
  # Inside the like model there is no association called lied question so we have to specificy the source for Rails to know how to match it
  has_many :liked_questions, through: :likes, source: :question

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX

  # Find out all the users whose first_name, last_name or email exactly matches a given string: search_term
#   def self.strict_search(search_term)
#     where(["first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?" , "#{search_term}", "#{search_term}", "#{search_term}"])
#   end
#
#   # Find out all the users whose first_name, last_name or email exactly or partially (string contained inside) matches a given string: search_term
#
#   def self.loose_search(search_term)
#     where(["first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?" , "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"])
#   end
#
#   # Find all the users whose neither first_name nor last_name is "john"
#
#   def self.not_john
#     #both of these work
#     # where.not(first_name: "Alf", last_name: "Kohler")
#     where("first_name NOT ILIKE ? AND last_name NOT ILIKE ?", 'Alf', 'Kohler')
#   end
#
#   # Write a scope that takes a parameter and return all users created after given date...
#   # For example, I can call something like: User.created_after(10.days.ago)
#
#   def self.created_after(givendate)
#     where("created_at >= ? AND created_at <= ?", givendate, DateTime.now )
# # scope :within_range, lambda { where("created_at <= ? AND created_at >= ?", Date.today + 100, Date.today - 100) }
#   end

  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_password_reset_data
    generate_password_reset_token
    self.password_reset_requested_at = Time.now
    save
  end

  def password_reset_expired?
    password_reset_requested_at < 30.minutes.ago
  end

  private

  def generate_password_reset_token
    begin
      self.password_reset_token = SecureRandom.hex(32)
    end while User.exists?(password_reset_token: self.password_reset_token)
  end



end
