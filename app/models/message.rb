class Message < ActiveRecord::Base
  attr_accessor :full_name, :phone, :recipient, :to_address
  has_ancestry
  
  belongs_to :client
  belongs_to :project
  belongs_to :conversation
  has_many :message_receipts
  has_many :attachments, as: :attachable 

  before_create :get_sender
  after_create :create_receipts, :create_interaction

  validates_presence_of :email, :subject

   

   def find_sender
    message_receipts.where(:mailbox_type == "Sent").first.sender
   end



   def get_sender
      unless source == "CONTACT_FORM_USER"
       	Contact.find_by(:email => email)
      else
        
        Contact.find_or_create_by(:email => email) do |contact|
         curr_user = User.find_by_email(email)
        
         contact.first_name = curr_user.first_name
         contact.last_name = curr_user.last_name
       end
      end
  end
   
   
   def get_receiver
      Contact.find_by_email(recipient)
   end 

   

   private


   def create_receipts 
   		create_receipt_for_recipients 
   		create_receipt_for_sender
   end 
   def create_interaction
     Interaction.create(
      event: "Sent a message",
      content: self.body, 
      interactive_id: get_sender.id, 
      interactive_type: get_sender.class  
    )
   end 
 
   def create_receipt_for_recipients
   	 MessageReceipt.create(
      message: self,
      receivable_id: get_receiver.id, 
      receivable_type: get_receiver.class,
      sender_id: get_sender.id,
      sender_type: get_sender.class,
      read: false, 
      mailbox_type: "Inbox"

      
    )
   end 
   def create_receipt_for_sender
   	 MessageReceipt.create(
      message: self,
      receivable_id: get_sender.id, 
      receivable_type: get_sender.class,
      sender_id: get_receiver.id, 
      sender_type: get_receiver.class,
      read: false, 
      mailbox_type: "Sent"

      
    )
   end 
end

