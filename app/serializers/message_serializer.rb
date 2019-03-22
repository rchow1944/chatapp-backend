class MessageSerializer < ActiveModel::Serializer
  attributes :id, :room_id, :content, :created_at
end
