class ContactGroupsController < ApplicationController
  respond_to :js
  # GET /contact_groups
  # GET /contact_groups.xml
  load_and_authorize_resource

  def index
    @contact_groups = current_user.contact_groups.paginate(:page => params[:page], :per_page => 15)

    respond_to do |format|
      format.xml { render :xml => @contact_groups }
      format.js { render_to_facebox }
    end
  end

  # GET /contact_groups/1
  # GET /contact_groups/1.xml
  def show
    @contact_group = current_user.contact_groups.find(params[:id])

    respond_to do |format|
      format.xml { render :xml => @contact_group }
      format.js { render_to_facebox }
    end
  end

  # GET /contact_groups/new
  # GET /contact_groups/new.xml
  def new
    @contact_group = current_user.contact_groups.build

    respond_to do |format|
      format.xml { render :xml => @contact_group }
      format.js { render_to_facebox }
    end
  end

  # GET /contact_groups/1/edit
  def edit
    @contact_group = ContactGroup.find(params[:id])
    respond_to do |format|
      format.js { render_to_facebox }
    end
  end

  # POST /contact_groups
  # POST /contact_groups.xml
  def create
    @contact_group = current_user.contact_groups.build(params[:contact_group])
    @contact_group.save
    respond_to do |format|
      format.js { render :update }
    end
  end

  # PUT /contact_groups/1
  # PUT /contact_groups/1.xml
  def update
    @contact_group = current_user.contact_groups.find(params[:id])
    @contact_group.update_attributes(params[:contact_group])
    respond_to do |format|
      format.js
    end
  end

  # DELETE /contact_groups/1
  # DELETE /contact_groups/1.xml
  def destroy
    @contact_group = current_user.contact_groups.find(params[:id])
    @contact_group.destroy
    render :nothing => true
  end


  def add_to_group_form
    @group = current_user.contact_groups.build
    @contact_list = "nil"
    respond_with(@contact_list) do |format|
      format.js { render_to_facebox }
    end
  end

  def add_to_group
    if params[:group_type] == 'existing'
      @group = ContactGroup.find(params[:group]['id'])
    else
      @group = current_user.contact_groups.create(params[:contact_group])
    end
    @contact_count = 0
    if @group.present? && !@group.new_record?
      if params[:cb] != nil
        contacts = ContactGroupsContact.add_group_contacts(@group.id, params[:cb])
        @contact_count = contacts.count if contacts.any?
      end
    end

    respond_with(@group) do |format|
      format.js
    end
  end
end
