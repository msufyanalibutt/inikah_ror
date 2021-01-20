module Admin
  class ContactsController < BaseController
    def index
      @contacts = Contact.all
    end
  end
end