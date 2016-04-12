class Product < ActiveRecord::Base

  # Find all products priced more than 70 and less than 100. Order them by name and limit the results to 10 products.
  def self.within_range_search
    where(["price > ? AND price < ?", 70, 100]).order("name").limit(10)
  end


# Write a code to validate the presence and uniqueness (case insensitive) in one line.
validates :name, :price, presence: true, uniqueness: {case_sensitive: false, message: "Must be unique!"}


where("first_name NOT ILIKE ? AND last_name NOT ILIKE ?", 'Alf', 'Kohler')
# Write a validation that makes sure that the name is present, unique and that it's not any of these reserved words: Apple, Microsoft & Sony.
# validates(:name, {presence: true, uniqueness: {message: "Must be unique!"}, exclusion: {in: %w(Apple Microsoft Sony), message: "%{value} is reserved." }})


  # Write a callback method that logs: "Product is about to be deleted" in the model before it's destroyed.
before_destroy :delete_warning



# Write a validation that ensures that the sale price is not higher than the price.
validate :sale_price_not_higher_than_regular_price


# Given a product model with: name, price and hit_count
# Write a code that will increment and save the hit_count (only method call)
def product_hit_count_increment
  if self.hit_count == nil
    self.hit_count = 1
  else
  self.hit_count += 1
  end
end

private

def sale_price_not_higher_than_regular_price
  if sale_price > price
    errors.add(:sale_price, "Higher than regular price!")
  end
end


  def delete_warning
    puts "Product is about to be deleted!"
  end



end
