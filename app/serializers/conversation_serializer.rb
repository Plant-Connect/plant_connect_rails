class ConversationSerializer
  include JSONAPI::Serializer
  attributes :name, :messages
end
