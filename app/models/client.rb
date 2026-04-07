class Client < ApplicationRecord
  has_many :company_clients
  has_many :orders

  before_validation :ensure_email

  validates :email, presence: true
  validate :email_or_phone_present

  private

  def ensure_email
    return if email.present?

    self.email = "user_#{SecureRandom.uuid}@noemail.com"
  end

  def email_or_phone_present
    if email.blank? && phone.blank?
      errors.add(:base, "email or phone must be present")
    end
  end
end