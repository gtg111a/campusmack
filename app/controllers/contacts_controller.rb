  class ContactsController < ApplicationController
    # GET /contacts
    # GET /contacts.xml
    load_and_authorize_resource
    def index
      @contacts = current_user.contacts.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @contacts }
      end
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

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @contact }
      end
    end

    # GET /contacts/1/edit
    def edit
      @contact = Contact.find(params[:id])
    end

    # POST /contacts
    # POST /contacts.xml
    def create
      @contact = current_user.contacts.build(params[:contact])

      respond_to do |format|
        if @contact.save
          format.html { redirect_to(@contact, :notice => 'Contact was successfully created.') }
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
          format.html { redirect_to(@contact, :notice => 'Contact was successfully updated.') }
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
      flash[:notice] = "#{import_count} contacts imported"
      respond_to do |format|
        format.js { render(:update){|page| page.redirect_to(contacts_path) } }
        #format.js { redirect_to(contacts_path) } #render_to_facebox(:html => "test")
      end
    end

  end