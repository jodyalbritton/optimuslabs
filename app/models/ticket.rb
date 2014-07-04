class Ticket < ActiveRecord::Base
  include AASM
  belongs_to :client
  belongs_to :severity_type
  belongs_to :ticket_status
  has_many :interactions, as: :interactive
  
  before_update :adjust_status

  validates_presence_of :client
  validates_presence_of :subject
  validates_presence_of :description

  def total_time
    self.interactions.sum :time
  end
  

  aasm do
    state :opened, :initial => true
    state :pending
    state :in_progress
    state :closed

    event :progress, :after => Proc.new { progress_ticket } do
      transitions :from => [:opened, :closed, :pending], :to => :in_progress
    end

    event :pend, :after => Proc.new { pend_ticket } do
      transitions :from => [:opened, :closed, :in_progress], :to => :pending
    end

    event :open, :after => Proc.new { open_ticket } do
      transitions :from => [:pending, :closed, :in_progress], :to => :opened
    end

    event :close, :after => Proc.new { close_ticket } do
      transitions :from => [:pending, :opened, :in_progress], :to => :closed

    end
  end

  def close_ticket
      self.closed_at = Time.now
  end

  def open_ticket
      
  end

  def pend_ticket
    self.pended_at = Time.now
  end

  def progress_ticket
    self.in_progress_at = Time.now
  end

  def adjust_status
    case self.status
      when "closed"
       if self.closed? == false
        self.close
       end
      when "in_progress"
       if self.in_progress? == false
        self.progress
       end
      when "pending"
      if self.pending? == false  
        self.pend
      end
      when "opened"
       if self.opened? == false 
        self.open
       end
    end
  end

  ####  Client Name Auto-complete ####
    def client_name
      self.client.try(:name)
    end

    def client_name=(name)
      self.client = Client.find_by(name: name) if name.present?
    end
  ####  Set the class for the ticket badge color ####
  def get_label
  	if self.opened?
  		"success"
    elsif self.pending?
    	"warning"
    elsif self.in_progress?
    	"info"
    else	
        "default"
    end
  end
end
