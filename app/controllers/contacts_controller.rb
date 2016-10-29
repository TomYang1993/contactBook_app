class ContactsController < ApplicationController
before_action :authenticate_user!

  def index
    @contact = current_user.contacts

    #@contact = Contact.all   #current_user.contacts
    #@contact = Contact.where(user_id: current_user.id)

  end

  def show
    @contact = Contact.find_by(id: params[:id])
  end

  def new
    render "new.html.erb"
  end

  def create
    coordinates = Geocoder.coordinates(params[:address])
    contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      middle_name: params[:middle_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
      longitude: coordinates[1],
      latitude: coordinates[0],
      user_id: current_user.id
    )
    contact.save
    if contact.valid?
      flash[:success] = "contact is successfully created!"
      redirect_to "/contacts/#{contact.id}"
    else
      flash[:danger] = contact.errors.full_messages
      redirect_to "/contacts/new"
    end
  end

  def edit
    @contact = Contact.find_by(id: params[:id])
    render "edit.html.erb"
  end

  def update
    contact = Contact.find_by(id: params[:id])
    contact.update(
      first_name: params[:first_name],
      last_name: params[:last_name],
      middle_name: params[:middle_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
    )
    flash[:success] = "#{contact.id} was successfully updated!!!"
    redirect_to "/contacts/#{contact.id}"
  end

  def destroy
    contact = Contact.find_by(id: params[:id])
    contact.destroy
  end
end
