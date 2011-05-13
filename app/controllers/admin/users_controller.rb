module Admin
  class UsersController < BaseController

    include ActionView::Helpers::SanitizeHelper
    extend ActionView::Helpers::SanitizeHelper::ClassMethods
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::NumberHelper

    sections 'users'
    
    def index
      @users = User.all
    end

    def new
      @user = User.new
    end
    
    def create
      p params
      @user = User.create(params[:user])
      #current_site.memberships.create(:user => @user) if @user.errors.empty?
      if @user = User.create(params[:user])
        respond_with @user, :location => admin_users_url
      else
        render "edit"
      end
    end
    
    def edit
      p params
      @user = User.find(params[:id])
      respond_with @user, :location => edit_admin_user_url
    end
  end

end
