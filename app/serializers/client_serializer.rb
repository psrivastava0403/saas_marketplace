class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone

  def email
    return nil if object.email.include?("@noemail.com")
    object.email
  end
end