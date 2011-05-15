module Admin
  class UsersController < BaseController

    sections 'users'
    
    def index
      @users = User.all
    end

    def new
      @user = User.new(params[:user])
    end
    
    def create
      @user = User.create(params[:user])
      #current_site.memberships.create(:user => @user) if @user.errors.empty?
      if @user.errors.empty?
        redirect_to admin_users_path
      else
        flash[:notice] = @user.errors
        redirect_to new_admin_user_path params
      end
    end
    
    def edit
      @user = User.find(params[:id])
      respond_with @user, :location => edit_admin_user_url
    end
    
    def destroy
      @user = User.find params[:id]
      if @user.destroy
        flash[:notice] = t(".user_deleted")
        redirect_to admin_users_path
      else
        
      end
    end
    
  end

end
