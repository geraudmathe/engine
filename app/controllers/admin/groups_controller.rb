module Admin
  class GroupsController < BaseController

    defaults :instance_name => 'site'

    sections 'groups', 'site'

    actions :edit, :update

    respond_to :json, :only => :update
    
    def index
      @groups = Group.all
    end
    
    def new
      @group = Group.new(params[:group])
    end
    
    def edit
      @group = Group.find(params[:id])
      @users = User.not_in_group @group.user_ids
    end
    
    def show
      @group = Group.find params[:id]
    end
    
    def addgroupuser
      @group = Group.find params[:id]
      @group.user_ids << params[:user_id]
      @group.save!
      render :nothing => true
    end
    
    def removegroupuser
      @group = Group.find params[:id]
      p @group.members
      p @group.members.delete params[:user_id]
      p @group.members
      @group.save!
      render :nothing => true
    end
    
    def destroy
      @group = Group.find params[:id]
      if @group.destroy
        flash[:notice] = t(".group_deleted")
        redirect_to admin_groups_path
      else
        flash[:notice] = t(".error_occured")
        redirect_to admin_groups_path
      end
    end
    
    def update
      @group = Group.find params[:id]
      if @group.update_attributes params[:group]
        flash[:notice] = t ".group_updated"
      else
        flash[:notice] = ".error_occured"
      end
      
      redirect_to admin_groups_path
    end
    
    def create
      @group = Group.new(params[:group])
      if @group.save!
        flash[:notice] = t(".group_added")
        redirect_to edit_admin_group_url @group
      else
        flash[:notice] = t(".group_not_added")
        redirect_to new_admin_group_url @group
      end
    end
    
  end
end
