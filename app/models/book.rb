class GoodnessValidator < ActiveModel::Validator
    def validate(record)
        if record.author.downcase != "aayush"
            record.errors.add :author, "This person is not Aayush"
        end
    end
end

class Book < ApplicationRecord
    validates :book_title, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z]+\z/, message: "can have alphabets only"}, confirmation: true
    validates :author, presence: true, length: {in: (3..15)}
    validates :year, presence: true, comparison: {less_than: 2022}, inclusion: { in: (2015...2022), message: "must be between 2015 and 2022"}
    validates :rating, presence: true, numericality: true, inclusion: {in: (0..5), message: "must be between 0 and 5"}
    validates_with GoodnessValidator
    validates_each :book_title, :author do |record, attr, value|
        record.errors.add(attr, 'must start with upper case') if value =~ /\A[[:lower:]]/
    end
    validates :checkbox, acceptance: true
end
