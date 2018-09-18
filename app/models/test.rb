class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User"
  has_many :questions, dependent: :destroy
  has_many :tests_users
  has_many :users, through: :tests_users

  validates :title, presence: true, uniqueness: { scope: :level }

  validate :validate_test_level

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

   private

   def validate_test_level
    errors.add(:level) unless level.is_a?(Integer) && level > 0
   end
end
