require 'digest'

class Group

  include Locomotive::Mongoid::Document
  
  field :name
  field :description, type: String
  field :members, type: Array
  field :opened, type: Boolean
  field :public, type: Boolean
  has_and_belongs_to_many :users
=begin  
  def users
    #TODO: User.any_in [] don't work when writing this method view the patchs soon
    members.map { |m| User.find m }.flatten
  end
=end
  def users!
    return members?
  end
  
end
