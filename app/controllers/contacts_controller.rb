class ContactsController < ApplicationController
  authorize_resource

  def index
    breadcrumbs.add 'Contacts'
    @group = ContactGroup.find_by_id(params[:group_id])
    @contact_groups = current_user.contact_groups
    @contacts = if @group
                  @group.contacts
                else
                  @group = ContactGroup.new(:name => 'All')
                  current_user.contacts
                end.paginate(:page => params[:page], :per_page => params[:per])

  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = current_user.contacts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = current_user.contacts.build
    breadcrumbs.add 'Contacts', contacts_path
    breadcrumbs.add 'New Contact'
    respond_to do |format|
      format.js {render_to_facebox}
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    breadcrumbs.add 'Contacts', contacts_path
    breadcrumbs.add 'Edit Contact'
    @contact = Contact.find(params[:id])
    respond_to do |format|
      format.js {render_to_facebox}
    end
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = current_user.contacts.build(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to contacts_url, :notice => 'Contact was successfully created.' }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = current_user.contacts.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to contacts_url, :notice => 'Contact was successfully updated.' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end

  def import
    @contacts = current_user.contacts.import(current_user, params[:contact])
    import_count = @contacts.count(){|contact| contact.errors.blank?}
    respond_to do |format|
      format.js { render(:update){|page| page.redirect_to(contacts_path) } }
    end
  end
  
  def get_group_emails
    @group_ids = params[:cb]
    respond_to do |format|
      format.js # index.html.erb
      format.xml  { render :xml => @text }
    end
  end

  def delete_emails
    @contacts_ids = params[:cb]
    @contacts_ids.each { |id|
      @contact = current_user.contacts.find(id)
      @contact.destroy
    }
    flash[:notice] = "#{@contacts_ids.count} contacts deleted"
  end

  def remove_emails_from_group
    @contacts_ids = params[:cb]
    if @contacts_ids != nil
      @contacts_ids.each { |id|
        contact = current_user.contacts.find(id)
        contact_group = contact.contact_groups
        contact_group.delete(contact_group)
      }
    end
  end

end


