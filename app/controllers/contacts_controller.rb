class ContactsController < ApplicationController
  authorize_resource

  before_filter :add_breadcrumbs, :only => [:index]

  def index
    @group = ContactGroup.find_by_id(params[:group_id])
    @contact_groups = current_user.contact_groups
    @contacts = if @group
                  @group.contacts.search(params[:search])
                else
                  @group = ContactGroup.new(:name => 'All')
                  current_user.contacts.search(params[:search])
                end.order("name ASC").paginate(:page => params[:page], :per_page => params[:per])
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = current_user.contacts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @contact }
    end
  end

  def new
    @contact = current_user.contacts.build
    respond_to do |format|
      format.js { render_to_facebox }
      format.xml { render :xml => @contact }
    end
  end

  def edit
    @contact = Contact.find(params[:id])
    respond_to do |format|
      format.js { render_to_facebox }
    end
  end

  def create
    contact = current_user.contacts.build(params[:contact])

    if contact.save
      unless params[:group_id].empty?
        contact_group = current_user.contact_groups.find(params[:group_id])
        contact.contact_groups << contact_group
      end
    end

    respond_to do |format|
      format.js
    end
  end

  def update
    contact = current_user.contacts.find(params[:id])
    contact.update_attributes(params[:contact])

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @contact = current_user.contacts.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml { head :ok }
    end
  end

  def import
    @contacts = current_user.contacts.import(current_user, params[:contact])
    errors = {}
    import_count = @contacts.count() do |contact|
      valid = contact.errors.blank?
      unless valid
        errors[contact.errors.first] ||= 0
        errors[contact.errors.first] += 1
      end
      valid
    end
    flash[:notice] = "#{import_count} out of #{@contacts.count} contacts has been imported."
    if errors.keys.any?
      flash[:error] = ''
      errors.each { |error| flash[:error] << "#{error.last} contacts can not be imported because of '#{error.first.join(' ')}'" }
    end
    respond_to do |format|
      format.js { render(:update) { |page| page.redirect_to :back } }
    end
  end

  def get_group_emails
    @group_ids = params[:cb]
    respond_to do |format|
      format.js # index.html.erb
      format.xml { render :xml => @text }
    end
  end

  def delete_emails
    @contacts_ids = params[:cb]
    @contacts_ids.each { |id|
      @contact = current_user.contacts.find(id)
      @contact.destroy
    }
  end

  def remove_emails_from_group
    @contacts_ids = params[:cb]
    if @contacts_ids != nil
      @contacts_ids.each { |id|
        contact = current_user.contacts.find(id)
        contact_group = contact.contact_groups
        contact_item = ContactGroup.find(params[:group_id])
        contact_group.delete(contact_item)
      }
    end
  end

end
