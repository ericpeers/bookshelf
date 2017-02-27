class Rating < ApplicationRecord
  belongs_to :book

  validates :rating, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 10}

  validate :read_before_rating

  def read_before_rating
    if ( (was_read.nil? || !was_read) && (! rating.nil?) )
      errors.add(:was_read, "You need to read the book before you can rate it.")
    end


  end

end
