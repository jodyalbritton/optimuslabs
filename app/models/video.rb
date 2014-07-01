class Video < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :category
  acts_as_taggable # Alias for acts_as_taggable_on
  

  before_update :update_details

  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*\z/i

  before_create -> do
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


  def get_details
    client = YouTubeIt::OAuth2Client.new(dev_key: ENV['YT_DEV'])
    client.video_by(self.uid)
  end

  private


  def get_additional_info
    begin
      client = YouTubeIt::OAuth2Client.new(dev_key: ENV['YT_DEV'])
      video = client.video_by(uid)
      self.title = video.title
      self.duration = parse_duration(video.duration)
      self.author = video.author.name
      self.likes = video.rating.try(:likes)
      self.views = video.try(:view_count)
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
