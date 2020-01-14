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

    def show
        @project = Project.find_by(projectid: params[:projectid])
    end

    def update
        params[:project][:user_id] = session[:id]
        # render plain: params[:project].inspect
        @project = Project.find_by(projectid: params[:projectid])
        if (@project.update(project_params))
            flash[:success] = "Project Updated Successfully"
            redirect_to projects_users_path
        else
            render 'users/edit_project'
        end
    end

    def destroy
        @project = Project.find_by(projectid: params[:projectid])
        @project.destroy
        flash[:error] = "Project Deleted Successfully"
        redirect_to projects_users_path
        # render plain: @project.inspect
    end

    def project_params
        params.require(:project).permit(:title, :description, :user_id, :projectid)
    end
end
