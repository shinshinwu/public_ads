class Inquiry < ActiveRecord::Base
  belongs_to :listing
  has_many :transactions
  belongs_to :conversation, class_name: "Mailboxer::Conversation", foreign_key: "conversation_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"

end