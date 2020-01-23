class UsersController < ApplicationController
    # layout :resolve_layout
    before_action :authorize_login, :only => [:login, :new]
    before_action :authorize_logout, :only => [:dashboard, :profile, :projects, :create_project, :edit_project, :show, :logout, :destroy, :threads, :add_thread]
    def index
        @user = User.new
    end

    def login
        @user = User.new
    end

    def submit_login
        # render plain: user_params.inspect
        @user = User.find_by_email(user_params[:email])
        if @user and @user.authenticate(user_params[:password])
            session[:logged_in] = true
            session[:email] = user_params[:email]
            session[:userid] = @user[:userid]
            session[:id] = @user[:id]
            # render plain: @user[:id]
            redirect_to dashboard_users_path, :flash => { :success => "You are logged in successfully as #{session[:email]}" }
        else
            # render plain: user_params
            if user_params[:email] == "" and user_params[:password] == ""
                flash[:error] = "Please Provide Email And Password"
            elsif user_params[:email] == ""
                flash[:error] = "Please Provide Email Address"
            elsif user_params[:password] == ""
                flash[:error] = "Please Provide Password"
            elsif @user == nil
                flash[:error] = "Incorrect Email Provided"
            elsif @user != nil and @user[:email] != ""
                flash[:error] = "Incorrect Password Provided"
            else
                flash[:error] = "Please Provide Correct Email And Password"
            end

            render 'login'
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        @user[:userid] = SecureRandom.uuid
        # render plain: @user.inspect
        if (@user.save)
            redirect_to login_users_path, :flash => { :success => "You have successfully signed up. Please login now" }
        else
            render 'new'
        end
    end

    def dashboard
    end

    def profile
    end

    def update
        # render plain: user_params.inspect
        # @user = User.find_by_email(user_params)
    end

    def submit_profile
        @user = User.find_by_email(session[:email])
        if user_params[:email] == ""
            flash[:error] = "Please Provide A Valid Email Address"
            render 'profile'
        elsif user_params[:fullname] == ""
            flash[:error] = "Please Provide Your Full Name"
            render 'profile'
        else
            if (@user.update(user_params))
                flash[:success] = "Profile Updated Successfully"
                redirect_to profile_users_path
            else
                flash[:error] = "Profile Not Updated"
                render 'profile'
            end
        end
    end

    def projects
        @pagy, @projects = pagy(@user.projects, items: 5)
        @bgs = ["#68428a","#a64791","#855635","#4c7e8a","#323e7a","#943469","#4d2227","#b05638","#4d0b47","#992b59","#1b5780","#046e6e","#254a22","#6d8748","#5d6344"]
        # render plain: @projects.inspect
    end

    def create_project
        @user = User.find_by_email(session[:email])
        # render plain: @user.inspect
    end

    def edit_project
        @project = Project.find_by(projectid: params[:projectid])
    end

    def show
        @active = "profile"
    end

    def destroy
        render plain: "Finally Destroyed"
        @user.destroy
        session[:logged_in] = session[:id] = session[:userid] = session[:email] = nil
        flash[:error] = "Account Deleted Successfully"
        redirect_to login_users_path
    end

    def threads
        @project = Project.find_by(projectid: params[:projectid])
        @project_thread = ProjectThread.find_by(project_thread_id: params[:thread_id])
        @message = Message.new
        @bgs = ["#68428a","#a64791","#855635","#4c7e8a","#323e7a","#943469","#4d2227","#b05638","#4d0b47","#992b59","#1b5780","#046e6e","#254a22","#6d8748","#5d6344"]
        # render plain: @project_thread.messages.inspect
    end

    def shared_projects
        @projects = ProjectUser.where("user_id = ?", session[:id])
        @pagy, @projects = pagy(@projects, items: 5)
        @bgs = ["#68428a","#a64791","#855635","#4c7e8a","#323e7a","#943469","#4d2227","#b05638","#4d0b47","#992b59","#1b5780","#046e6e","#254a22","#6d8748","#5d6344"]
        # render plain: @projects[0].project.inspect
    end

    def logout
        session[:logged_in] = session[:id] = session[:userid] = session[:email] = nil
        flash[:error] = "You have logged out successfuly! Please login again"
        redirect_to login_users_path
    end

    def tasks
        @project = Project.find_by(projectid: params[:projectid])
    end

    def add_task
        @task = Task.new
        @project = Project.find_by(projectid: params[:projectid])
    end

    def create_task
        @task = Task.new(task_params)
        @project = Project.find_by(projectid: params[:projectid])
        @task.project_id = @project[:id]
        @task.user_id = @project[:user_id]
        @task.task_id = SecureRandom.uuid
        
        if (@task.save)
            flash[:success] = "Task created Successfully"
            redirect_to projects_users_path + "/#{params[:projectid]}/tasks"
        else
            flash[:error] = "You have some errors there"
            render 'add_task'
        end
    end

    def edit_task
        @task = Task.find_by(task_id: params[:task_id])
        @project = Project.find_by(projectid: params[:projectid])
    end

    def update_task
        @task = Task.find_by(task_id: params[:task_id])
        if @task.update(task_params)
            flash[:success] = "Task updated Successfully"
            redirect_to projects_users_path + "/#{params[:projectid]}/tasks"
        else
            flash[:error] = "You have some errors there"
            render 'edit_task'
        end
    end

    def delete_task
        @task = Task.find_by(task_id: params[:task_id])
        @task.destroy
        flash[:error] = "Task deleted Successfully"
        redirect_to projects_users_path + "/#{params[:projectid]}/tasks"
    end

    private
        def user_params
            params.require(:user).permit(:fullname, :email, :password)
        end

        def task_params
            params.require(:task).permit(:title)
        end

        def resolve_layout
            case action_name
            when "threads"
                "index_layout"
            else
                "application"
            end
        end

end
# http://localhost:3000/users/projects/c8cba1f2-43ca-4229-acc3-a8e305a961ed/users