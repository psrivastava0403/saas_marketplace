class Client < ApplicationRecord
  has_many :company_clients
  has_many :orders

  before_validation :generate_dummy_email, if: :needs_dummy_email?

  validate :email_or_phone_present

  private

  def email_or_phone_present
    if email.blank? && phone.blank?
      errors.add(:base, "email or phone must be present")
    end
  end

  def needs_dummy_email?
    email.blank? && phone.present?
  end

  def generate_dummy_email
    self.email = "user_#{SecureRandom.uuid}@noemail.com"
  end
end