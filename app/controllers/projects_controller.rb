class ProjectsController < ApplicationController
    def create
        params[:project][:user_id] = session[:id]
        params[:project][:projectid] = SecureRandom.uuid
        # render plain: project_params
        @project = Project.new(project_params)
        # render plain: @project.inspect
        if (@project.save)
            flash[:success] = "Project Created Successfully"
            redirect_to projects_users_path
        else
            # render plain: @project.inspect
            flash[:error] = "Project Not Created Successfully"
            render 'users/create_project'
        end
    end

    def project_params
        params.require(:project).permit(:title, :description, :user_id, :projectid)
    end
end
