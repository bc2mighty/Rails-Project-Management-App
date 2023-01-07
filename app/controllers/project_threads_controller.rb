# frozen_string_literal: true

class ProjectThreadsController < ApplicationController
  def create
    @project = Project.find_by(projectid: params[:projectid])
    @project_thread = ProjectThread.new(project_thread_params)
    @project_thread[:project_thread_id] = SecureRandom.uuid
    @project_thread[:project_id] = @project[:id]
    @project_thread[:user_id] = session[:id]
    # render plain: @project_thread.inspect

    if @project_thread.save
      flash[:success] = 'Thread created successfully'
      redirect_to "#{users_path}/projects/threads/#{params[:projectid]}"
    else
      flash[:error] = 'Thread could not be created'
      render 'projects/add_thread'
    end
  end

  def update
    @project_thread = ProjectThread.find_by(project_thread_id: params[:thread_id])
    @project_thread[:topic] = project_thread_params[:topic]
    @project_thread[:description] = project_thread_params[:description]
    if @project_thread.save
      flash[:success] = 'Thread updated successfully'
      redirect_to "#{users_path}/projects/threads/#{params[:projectid]}"
    else
      flash[:error] = 'Thread could not be updated'
      render 'projects/edit_thread'
    end
  end

  def destroy
    @project_thread = ProjectThread.find_by(project_thread_id: params[:thread_id])
    @project_thread.destroy
    flash[:error] = 'Thread deleted successfully!'
    redirect_to "#{users_path}/projects/threads/#{params[:projectid]}"
  end

  private

  def project_thread_params
    params.require(:project_thread).permit(:topic, :description)
  end
end
