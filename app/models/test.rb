class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User"
  has_many :questions, dependent: :destroy
  has_many :tests_users
  has_many :users, through: :tests_users

  # def self.sorted_by_category(category)
  #   joins(:category)
  #     .where(categories: { title: category })
  #     .order(id: :desc)
  #     .pluck(:title)
  # end

   scope :sorted_by_category, ->(category) { joins(:category).where(categories: { title: category }).order(id: :desc) }#.pluck(:title) }

   scope :easy, -> { where(level: 0..1) }
   scope :medium, -> { where(level: 2..4) }
   scope :hard, -> {where(level: 5..Float::INFINITY) }
end
