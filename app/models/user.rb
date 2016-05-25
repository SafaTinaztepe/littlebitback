class User < ActiveRecord::Base
  has_many :campaigns
  has_many :comments

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

  def self.koala(auth)
  	token = auth[:token]
  	facebook = Koala::Facebook::API.new(token)
  	facebook.get_object("me?fields=picture")
  end

  def add_projects(campaign)
    '''runs after campaign is created'''
    campaign.ownership = self.id
    self.projects_owned.push(campaign.id)  
  end

  def get_projects
    return self.projects.split(',')
  end
end
