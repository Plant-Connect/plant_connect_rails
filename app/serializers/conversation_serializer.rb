class ConversationSerializer
  include JSONAPI::Serializer
  attributes :messages
end
