class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy,:open, :progress,:blocked,:closed]
  before_action :set_tasks, only: [:index, :open, :progress, :blocked, :closed, :destroy, :destroy_multiple, :sort_by_date]

  # GET /tasks
  # GET /tasks.json
  def index
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build()
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.build(task_params)
    respond_to do |format|
      if @task.save
        DailyReportEmailJob.perform_later(@task)
        flash[:success] = 'Task was successfully created.'
        format.html { redirect_to @task }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        flash[:success] = 'Task was successfully updated.'
        format.html { redirect_to @task }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    if @task.destroy
      flash[:success] = "Task was successfully destroyed."
      respond_update_tasks_list
    end
  end

  def destroy_multiple
    if params[:tasks]
      if current_user.tasks.where(id: params[:tasks]).delete_all
        flash[:success] = "#{params[:tasks].length} task#{"s" if params[:tasks].length > 1 } was successfully destroyed."
        respond_update_tasks_list
      end
    end
  end

  def open
    if @task.update_attribute :status, "open"
      flash[:success] = "Task made Open."
      respond_update_tasks_list
    else
      flash[:danger] = "Server error!"
    end
  end

  def progress
    if @task.update_attribute :status, "progress"
      flash[:success] = "Task made Progress."
      respond_update_tasks_list
    else
      flash[:danger] = "Server error!"
    end
  end

  def blocked
    if @task.update_attribute :status, "blocked"
      flash[:success] = "Task made blocked."
      respond_update_tasks_list
    else
      flash[:danger] = "Server error!"
    end
  end

  def closed
    if @task.update_attribute :status, "closed"
      flash[:success] = "Task made Closed."
      respond_update_tasks_list
    else
      flash[:danger] = "Server error!"
    end
  end

  def sort_by_date
    flash[:success] = "Tasks sorted by date."
    respond_update_tasks_list
  end

  def sort_by_title
    @tasks = current_user.tasks.order("title asc")
    @open_tasks = @tasks.where(status:"open")
    @progress_tasks = @tasks.where(status:"progress")
    @blocked_tasks = @tasks.where(status: "blocked")
    @closed_tasks = @tasks.where(status: "closed")
    flash[:success] = "Tasks sorted by title."
    respond_update_tasks_list
  end

  private

    def set_tasks
      @tasks = current_user.tasks
      @open_tasks = @tasks.where(status:"open")
      @progress_tasks = @tasks.where(status:"progress")
      @blocked_tasks = @tasks.where(status: "blocked")
      @closed_tasks = @tasks.where(status: "closed")
      @history_tasks = @tasks.order('updated_at desc')
    end

    def set_task
      if Task.exists?(params[:id]) && current_user == Task.find(params[:id]).user
        @task = Task.find(params[:id])
      end
      render_404 unless @task
    end

    def task_params
      params.require(:task).permit(:title, :description, :priority, :due_date, :status, :user_id,:assign_user_id)
    end

    def respond_update_tasks_list
      respond_to do |format|
        format.html { redirect_to tasks_path }
        format.json { head :no_content }
        format.js   { render partial: "tasks/shared/update_tasks_list", locals: { open_tasks: @open_tasks, progress_tasks: @progress_tasks,blocked_tasks: @blocked_tasks,closed_tasks: @closed_tasks,history_tasks: @history_tasks} }
      end
    end
end