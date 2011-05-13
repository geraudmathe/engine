require 'digest'

class User

  include Mongoid::Document

  # devise modules
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  #attr_accessible :email, :password, :password_confirmation # TODO

  ## attributes ##
  field :firstname
  field :lastname
  field :email
  field :society
  field :locale, :default => 'en'
  #field :switch_site_token

  ## validations ##
  #validates_presence_of :firstname,:lastname, :email

  ## associations ##

  ## callbacks ##
  before_destroy :remove_memberships!

  ## methods ##

  protected

  def password_required?
    !persisted? || !password.blank? || !password_confirmation.blank?
  end

  def remove_memberships!
    self.sites.each do |site|
      site.memberships.delete_if { |m| m.account_id == self._id }

      if site.admin_memberships.empty?
        raise I18n.t('errors.messages.needs_admin_account')
      else
        site.save
      end
    end
  end

end
