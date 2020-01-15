class ProjectsController < ApplicationController
    before_action :get_project, :only => [:attachments]
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
    end

    def attachments
        @projects = Project.find_by(projectid: params[:projectid])
        # @projects.attachments.each do |attachment|
        #     puts attachment
        # end
        # render plain: @projects.attachments.inspect
    end

    def upload_attachments
        # render plain: 
    end

    def get_project
        @project = Project.find_by(projectid: params[:projectid])
    end

    def project_params
        params.require(:project).permit(:title, :description, :user_id, :projectid)
    end
end
