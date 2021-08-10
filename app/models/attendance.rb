class Attendance < ApplicationRecord
  after_create :attendance_send

  belongs_to :user
  belongs_to :event

  validates :stripe_customer_id, presence: true

  def attendance_send
    UserMailer.attendance_email(user).deliver_now
  end
end
