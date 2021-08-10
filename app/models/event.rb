class Event < ApplicationRecord
  def set_in_past?
    start_date > Time.now
  end

  def multipe_of_five?
    (duration % 5).zero?
  end

  belongs_to :user
  has_many :attendances
  has_many :users, through: :attendances

  validates :start_date,
            presence: true,
            if: :set_in_past?

  validates :duration,
            if: :multipe_of_five?,
            numericality: { greater_than: 0, only_integer: true }

  validates :title,
            presence: true,
            length: { minimum: 5, maximum: 140 }

  validates :description,
            presence: true,
            length: { minimum: 20, maximum: 1000 }

  validates :price,
            presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: 1000, only_integer: true }

  validates :location,
            presence: true
end
