class ContactGroupsController < ApplicationController
  respond_to :js, :html
  # GET /contact_groups
  # GET /contact_groups.xml
  load_and_authorize_resource
  def index
    @contact_groups = current_user.contact_groups.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contact_groups }
    end
  end

  # GET /contact_groups/1
  # GET /contact_groups/1.xml
  def show
    @contact_group = current_user.contact_groups.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact_group }
    end
  end

  # GET /contact_groups/new
  # GET /contact_groups/new.xml
  def new
    @contact_group = current_user.contact_groups.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact_group }
    end
  end

  # GET /contact_groups/1/edit
  def edit
    @contact_group = ContactGroup.find(params[:id])
  end

  # POST /contact_groups
  # POST /contact_groups.xml
  def create
    @contact_group = current_user.contact_groups.build(params[:contact_group])

    respond_to do |format|
      if @contact_group.save
        format.html { redirect_to(@contact_group, :notice => 'Contact group was successfully created.') }
        format.xml  { render :xml => @contact_group, :status => :created, :location => @contact_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contact_groups/1
  # PUT /contact_groups/1.xml
  def update
    @contact_group = current_user.contact_groups.find(params[:id])

    respond_to do |format|
      if @contact_group.update_attributes(params[:contact_group])
        format.html { redirect_to(@contact_group, :notice => 'Contact group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_groups/1
  # DELETE /contact_groups/1.xml
  def destroy
    @contact_group = current_user.contact_groups.find(params[:id])
    @contact_group.destroy

    respond_to do |format|
      format.html { redirect_to(contact_groups_url) }
      format.xml  { head :ok }
    end
  end


  def add_to_group_form

    @contact_list ="nil"
    respond_with(@contact_list) do |format|
      format.js { render_to_facebox }
    end
  end

  def add_to_group
    @contacts = []
    group = nil
    @contact_count
    @new_group_name = ""
    @new_group_id = ''
    if params[:group_type]=='existing'
      @group_id = params[:name]['id']
      @contacts = ContactGroupsContact.add_group_contacts(@group_id,params[:cb])
      @contact_count = @contacts.count #(){|contact| contact.errors.blank?}

    else

      if params[:new_group_name].present? && params[:new_group_name].strip!=''
        group = ContactGroup.add_to_groupmodel(current_user,params[:new_group_name])
      end

      if group.present? && group['id'].present?
        @group_id = group['id']
        @new_group_name = params[:new_group_name];
        @contacts = ContactGroupsContact.add_group_contacts(@group_id.to_int,params[:cb])
        @contact_count = @contacts.count #(){|contact| contact.errors.blank?}
      end

    end

    @contact_list = ""
    respond_with(@contact_list) do |format|
      flash[:notice] = @contact_count.to_s + " contacts added to  #{ContactGroup.find(@group_id).name}"
      format.js #{ render_to_facebox }
    end

  end
end
