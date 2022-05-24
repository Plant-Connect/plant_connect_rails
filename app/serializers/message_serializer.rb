class MessageSerializer
  include JSONAPI::Serializer
  attributes :conversation_id, :user_id, :content
end
