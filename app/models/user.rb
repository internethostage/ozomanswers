class User < ActiveRecord::Base



  # Find out all the users whose first_name, last_name or email exactly matches a given string: search_term
  def self.strict_search(search_term)
    where(["first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?" , "#{search_term}", "#{search_term}", "#{search_term}"])
  end

  # Find out all the users whose first_name, last_name or email exactly or partially (string contained inside) matches a given string: search_term

  def self.loose_search(search_term)
    where(["first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?" , "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"])
  end

  # Find all the users whose neither first_name nor last_name is "john"

  def self.not_john
    #both of these work
    # where.not(first_name: "Alf", last_name: "Kohler")
    where("first_name NOT ILIKE ? AND last_name NOT ILIKE ?", 'Alf', 'Kohler')
  end

  # Write a scope that takes a parameter and return all users created after given date...
  # For example, I can call something like: User.created_after(10.days.ago)

  def self.created_after(givendate)
    where("created_at >= ? AND created_at <= ?", givendate, DateTime.now )
# scope :within_range, lambda { where("created_at <= ? AND created_at >= ?", Date.today + 100, Date.today - 100) }
  end


end
