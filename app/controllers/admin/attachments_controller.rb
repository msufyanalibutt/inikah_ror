module Admin
  class AttachmentsController < BaseController

    def index
      @attachments = User.all.map(&:images)
    end

    def approve
      @attachment = ActiveStorage::Attachment.find(params[:id])
      @attachment.update(visibility: true)
      UserMailer.attachment_request_approved(@attachment.record).deliver_now
      flash[:success] = 'Request approved'
      redirect_to admin_attachments_path
    end
  end
end
