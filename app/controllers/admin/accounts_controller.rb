module Admin
  class AccountsController < BaseController

    sections 'settings', 'account'
    actions :edit, :update

    respond_to :json, :only => :update
    def new
      @account = Account.new(:email => params[:email])
    end

    def create
      @account = Account.create(params[:account])
      current_site.memberships.create(:account => @account) if @account.errors.empty?

      respond_with @account, :location => edit_admin_current_site_url
    end
    
    def edit
      @account = Account.find(params[:id])
      p "update account"
    end

    def update
      update! { edit_admin_account_url }
    end
    
  end
end
