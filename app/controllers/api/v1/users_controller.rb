module Api
    module V1
        class UsersController < ApplicationController
            skip_before_action :verify_authenticity_token
            def index
                users = User.order('created_at DESC')
                render json: {status: 'SUCCESS', 'message': 'Loaded Users', data: users},status: :ok
            end

            def show
                user = User.find(params[:id])
                render json: {status: 'SUCCESS', 'message': 'Loaded User', data: user},status: :ok
            end

            def create
                user = User.new(user_params)
                user[:userid] = SecureRandom.uuid
                if user.save
                    render json: {status: 'SUCCESS', 'message': 'User saved successfully', data: user},status: :ok
                else
                    render json: {status: 'ERROR', 'message': 'User Not Saved', data: user.errors},status: :unprocessable_entity
                end
            end

            def destroy
                begin
                    user = User.find(params[:id])
                    user.destroy
                    render json: {status: "SUCCESS", message: 'User Deleted Successully', data: user}, status: :ok
                rescue ActiveRecord::RecordNotFound => e
                    render json: {status: 'ERROR', message: 'User Not Deleted', data: e},status: :unprocessable_entity
                end
            end

            def update
                begin
                    user = User.find(params[:id])
                    user.update_attributes(user_params)
                    render json: {status: "SUCCESS", message: "User Updated Successfully", data: user}, status: :ok
                rescue ActiveRecord::RecordNotFound => e
                    render json: {status: "ERROR", message: "User Not Updated", data: e}, status: :ok
                end
            end                

            private 
                def user_params
                    params.permit(:fullname, :email, :password)
                end
        end
    end
end