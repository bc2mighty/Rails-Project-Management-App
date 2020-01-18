module Api
    module V1
        class ProjectsController < ApplicationController
            skip_before_action :verify_authenticity_token
            def update_user
                begin
                    project_user = ProjectUser.find_by(project_user_id: project_user_params[:project_user_id])
                    if project_user == nil
                        render json: {status: "ERROR", message: "Update Not Successful. Access Not Found", data: "Wrong Project User ID Provided"}, status: :unprocessable_entity
                    else
                        project_user.update_attributes(project_user_params)
                        render json: {status: "SUCCESS", message: "User Access To Project Updated Successfully", data: params}, status: :ok
                    end
                rescue
                    render json: {status: "ERROR", message: "Updated Not Successful", data: "Wrong Project User ID Provided"}, status: :unprocessable_entity
                end
            end

            private
                def project_user_params
                    params.permit(:project_user_id, :write_access, :read_access, :update_access, :delete_access, :project_id)
                end
        end
    end
end