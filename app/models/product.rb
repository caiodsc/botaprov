class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
end