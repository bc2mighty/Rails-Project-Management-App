class AttachmentsController < ApplicationController
    def create
        @attachment = Attachment.new(attachment_params)
        @project = Project.find_by(projectid: params[:projectid])
        
        @attachment[:project_id] = @project[:id]
        @attachment[:userid] = session[:userid]
        # render plain: params[:attachment][:files].inspect
        if (params[:attachment][:files] == nil)
            flash[:error] = "Please Provide Files"
            render 'projects/upload_attachments'
        else
            @attachment.files.attach(params[:attachment][:files])
            if (@attachment.save)
                flash[:success] = "Attachment Uploaded Successfully"
                redirect_to users_path + "/projects/view/#{params[:projectid]}"
            else
                flash[:error] = "Attachment Not Uploaded Successfully"
                render 'projects/upload_attachments'
            end
            # render plain: params[:attachment][:files].inspect
        end
    end

    private
        def attachment_params
            params.require(:attachment).permit(:title, :files)
        end
end
