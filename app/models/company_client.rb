class CompanyClient < ApplicationRecord
  belongs_to :company
  belongs_to :client
end
