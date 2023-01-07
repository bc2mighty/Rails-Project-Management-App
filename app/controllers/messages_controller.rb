# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @project = Project.find_by(projectid: params[:projectid])
    @project_thread = ProjectThread.find_by(project_thread_id: params[:thread_id])

    @message[:message_id] = SecureRandom.uuid
    @message[:project_id] = @project[:id]
    @message[:project_thread_id] = @project_thread[:id]
    @message[:user_id] = session[:id]

    # render plain: params[:projectid].inspect

    if @message.save
      flash[:success] = 'Message submitted successsfully'
      redirect_to request.fullpath
    else
      flash[:error] = 'Message could not be created'
      render 'users/threads'
    end
  end

  def edit
    @project = Project.find_by(projectid: params[:projectid])
    @project_thread = ProjectThread.find_by(project_thread_id: params[:thread_id])
    @message = Message.find_by(message_id: params[:message_id])
  end

  def update
    @message = Message.find_by(message_id: params[:message_id])
    if @message.update(message_params)
      flash[:success] = 'Message submitted successsfully'
      redirect_to projects_users_path + "/#{params[:projectid]}/threads/#{params[:thread_id]}"
    else
      flash[:error] = 'Message could not be created'
      render 'edit'
    end
  end

  def destroy
    @message = Message.find_by(message_id: params[:message_id])
    @message.destroy
    flash[:error] = 'Message Deleted Successfully'
    redirect_to users_path + "/projects/#{params[:projectid]}/threads/#{params[:thread_id]}"
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end
end
