require 'jwt'
class TasksController < ApplicationController
  before_action :set_task, only: [:edit_task, :delete_task,:set_status]
  before_action :authenticate
  # GET /task_index
  def view_tasks
    #puts @current_user
    user_tasks = Task.where(user_id: @current_user.id)
    render json: user_tasks.all
  end

  def create
    #@task = @current_user.tasks.new(task_params) 
    @task = Task.new(task_params.merge({user_id: @current_user.id}))
    if @task.save      
    render json:  @task, status: :created, location: @task
    else
    render json:  @task.errors, status: :unprocessable_entity
    end
  end

  def edit_task
    params[:task][:status] = params[:task][:status].to_i
    #byebug
    if @task.update(task_params)
    render json: @task
    else
    render json: @task.errors, status: :unprocessable_entity
    end
  end
  
  def delete_task
    @task.destroy
    render json: {message: "task deleted"}   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
    @task = Task.find_by(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
    params.require(:task).permit(:task_title, :description, :status, :user_id)
    end
     
end
