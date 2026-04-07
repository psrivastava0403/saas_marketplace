class CompanyClient < ApplicationRecord
  belongs_to :company
  belongs_to :client

  validates :company_id, uniqueness: { scope: :client_id }
end