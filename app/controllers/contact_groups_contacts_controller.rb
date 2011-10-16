class ContactGroupsContactsController < ApplicationController

  authorize_resource
  def index
    @contact_groups_contacts = ContactGroupsContact.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contact_groups_contacts }
    end
  end

  def show
    @contact_groups_contact = ContactGroupsContact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact_groups_contact }
    end
  end

  def new
    @contact_groups_contact = ContactGroupsContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact_groups_contact }
    end
  end

  def edit
    @contact_groups_contact = ContactGroupsContact.find(params[:id])
  end

  # POST /contact_groups_contacts
  # POST /contact_groups_contacts.xml
  def create
    @contact_groups_contact = ContactGroupsContact.new(params[:contact_groups_contact])

    respond_to do |format|
      if @contact_groups_contact.save
        format.html { redirect_to(@contact_groups_contact, :notice => 'Contact created successfully.') }
        format.xml  { render :xml => @contact_groups_contact, :status => :created, :location => @contact_groups_contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact_groups_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @contact_groups_contact = ContactGroupsContact.find(params[:id])

    respond_to do |format|
      if @contact_groups_contact.update_attributes(params[:contact_groups_contact])
        format.html { redirect_to(@contact_groups_contact, :notice => 'Contact updated successfully.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact_groups_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact_groups_contact = ContactGroupsContact.find(params[:id])
    @contact_groups_contact.destroy

    respond_to do |format|
      format.html { redirect_to(contact_groups_contacts_url) }
      format.xml  { head :ok }
    end
  end
end
