class CompanyClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone

  def name
    object.name || object.client.name
  end

  def email
    email = object.email || object.client.email
    return nil if email&.include?("@noemail.com")
    email
  end

  def phone
    object.phone || object.client.phone
  end
end