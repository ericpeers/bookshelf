class Book < ApplicationRecord
  has_many :ratings,
           dependent: :destroy #chain deletion - if I delete my book, ratings go too.
  validates :title, presence: true,
            length: {minimum: 1} #C by Tom McCarthy is a legit book

  validates :author, presence: true,
            length: {minimum: 1} #assume that some author can have at least a single letter name or symbol like Prince.

  validates :isbn, uniqueness: true

  validate :isbn_length
  #this didn't work. So then I switched tactics
  #validates :isbn, length: {in: (10 13)}, uniqueness: true
  ##want the sequence 10,13; not the range 10..11.12.13.
  ##https://www.tutorialspoint.com/ruby/ruby_ranges.htm

  def isbn_length
    if (! ((isbn.length == 10) || (isbn.length == 13)))
      errors.add(:isbn, "ISBN should be either 10 or 13 characters (digits) long");
    end
  end


  def average_ratings
    @ratings = self.ratings
    total = 0;
    count = 0;
    @ratings.each do |rating|
      #it is possible to mark a book read and not give it a rating.
      if (! rating.rating.nil?)
        total += rating.rating
        count += 1
      end

    end

    if total == 0
      return 0
    else
      result = total/count
      return result
      #(rounding) is best handled in the view. Especially if somebody else wants this code for precise results.
      #return result.round(2) #don't return a super long float.
    end


  end


end
