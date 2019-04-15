class Book < ActiveRecord::Base
  belongs_to :user
  #ensure the book has a title. Is this right?
  validates_presence_of :title
end
