class GoodnessValidator < ActiveModel::Validator
    def validate(record)
        if record.author.split()[0].downcase != "aayush"
            record.errors.add :author, " is not Aayush"
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

    before_validation :removeWhitespaces
    after_validation :appendLastName
    before_save do |x|
        p "Before Save"
    end
    after_save do |x|
        p "After Save"
    end
    before_update do |x|
        p "Before Update"
    end
    after_update do |x|
        p "After Update"
    end
    before_destroy do |x|
        p "Before Destroy"
    end
    after_destroy do |x|
        p "After Destroy"
    end
    # around_save do |x|
    #     p "Around Save"
    #     # self.save!
    # end
    before_create do |x|
        p "Before Create"
        x.book_title += "\"Before create\""
    end
    after_create do |x|
        x.book_title = "AFTER CREATE"
        p x.book_title
    end
    # around_create do |x|
    #     p "Around Create"
    # end
    private
    def removeWhitespaces
        self.author.strip!
    end

    def appendLastName
        if self.author != nil
            self.author = author.split(' ')[-1].downcase == "adeshara" ? author : author.capitalize + " Adeshara"
        end
    end
end
