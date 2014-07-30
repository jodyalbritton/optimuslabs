class Video < ActiveRecord::Base
  after_update :update_details
  after_create :validate_slug 
  is_impressionable
  searchkick autocomplete: ['title']
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  include Rails.application.routes.url_helpers
  belongs_to :sponsor
  belongs_to :category
  acts_as_taggable # Alias for acts_as_taggable_on
  acts_as_votable
  acts_as_commentable
  has_attached_file :thumbnail, :styles => { :large => "750x450#", :medium => "360x244#", :thumb => "100x100#" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/

  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*\z/i

   before_create-> do
    uid = link.match(YT_LINK_FORMAT)

    self.uid = uid[2] if uid && uid[2]

    if self.uid.to_s.length != 11
      self.errors.add(:link, 'is invalid.')
      false
    elsif Video.where(uid: self.uid).any?
      self.errors.add(:link, 'is not unique.')
      false
    else
      get_additional_info
    end
  end

  validates :link, presence: true, format: YT_LINK_FORMAT

  def validate_slug 
    if self.slug == nil 
      self.save
    end
  end
  def thumbnail_remote_url
    thumb_url = 'http://img.youtube.com/vi/'+self.uid+'/hqdefault.jpg'
    self.thumbnail =  URI.parse(thumb_url)
  end
  
  def get_share_url
    video_url(self)
  end 

  def get_views 
    self.views + self.impressionist_count
  end
  
  def get_details
    client = YouTubeIt::OAuth2Client.new(dev_key: ENV['YT_DEV'])
    client.video_by(self.uid)
  end
  
  def category_name
    self.category.try(:name)
  end

  def category_name=(name)
    self.category = Category.find_or_create_by(name: name) if name.present?
  end
  def sponsor_name
    self.sponsor.try(:name)
  end

  def sponsor_name=(name)
    self.sponsor = Sponsor.find_by(name: name) if name.present?
  end
  private


  def get_additional_info
    begin
      client = YouTubeIt::OAuth2Client.new(dev_key: ENV['YT_DEV'])
      video = client.video_by(self.uid)
      self.title = video.title
      self.duration = parse_duration(video.duration)
      self.author = video.author.name
      self.likes = video.rating.try(:likes)
      self.views = video.try(:view_count)
      self.url = video.player_url
      self.embed = video.embed_html5
      self.description = video.try(:description)
      self.yt_updated_at = video.updated_at
      self.published_at  = video.published_at
      self.dislikes = video.rating.try(:dislikes)
      if self.likes == nil 
        self.likes = 0
      end
      if self.views == nil
        self.views = 0
      end
      if self.dislikes == nil
        self.dislikes = 0
      end 
      
       thumb_url = 'http://img.youtube.com/vi/'+self.uid+'/hqdefault.jpg'
       self.thumbnail =  URI.parse(thumb_url)
       
    rescue
      self.title = '' ; self.duration = '00:00:00' ; self.author = '' ; self.likes = 0 ; self.dislikes = 0
    end
  end



  def update_details
  
      client = YouTubeIt::OAuth2Client.new(dev_key: ENV['YT_DEV'])
      video = client.video_by(self.uid)
      self.title = video.title
      self.duration = parse_duration(video.duration)
      self.author = video.author.name
      self.likes = video.rating.try(:likes)
      self.views = video.try(:view_count)
      self.url = video.player_url
      self.embed = video.embed_html5
      self.description = video.try(:description)
      self.yt_updated_at = video.updated_at
      self.published_at  = video.published_at
      self.dislikes = video.rating.try(:dislikes)
      if self.likes == nil 
        self.likes = 0
      end
      if self.views == nil
        self.views = 0
      end
      if self.dislikes == nil
        self.dislikes = 0
      end  
      
   
  end
  def parse_duration(d)
    hr = (d / 3600).floor
    min = ((d - (hr * 3600)) / 60).floor
    sec = (d - (hr * 3600) - (min * 60)).floor

    hr = '0' + hr.to_s if hr.to_i < 10
    min = '0' + min.to_s if min.to_i < 10
    sec = '0' + sec.to_s if sec.to_i < 10

    hr.to_s + ':' + min.to_s + ':' + sec.to_s
  end

  
end
