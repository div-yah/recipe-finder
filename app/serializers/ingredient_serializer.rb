class IngredientSerializer < ActiveModel::Serializer
  attributes :id
  attribute :name, key: :text
end
