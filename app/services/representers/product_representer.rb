module ProductRepresenter
  include Roar::JSON::HAL

  property :name
  property :created_at, :writeable=>false

  link :self do
    "/products/#{id}"
  end
end