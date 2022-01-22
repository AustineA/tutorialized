class CoursesController < ApplicationController
  include Shared

  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:create, :my_courses]

  def index
    @courses = Course.all.order(created_at: :desc).limit(6)
  end

  def create
    @course = current_user.courses.build(course_params)
    slug = params[:course][:title]
    @course.slug = slug.parameterize

    if @course.save
      render json: {message: 'Success', slug: "/#{@course.slug}"}, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end
  
  def show
    @country = country_by_ip
  end

  def my_courses
    @orders = Order.where(user_id: current_user.id, status: true)
  end


  def update
      if @course.update(course_params)
        render :show
      else
        render json: @course.errors, status: :unprocessable_entity
      end
  end


  def destroy
    @course.destroy
  end

  private

  def set_course
    @course = Course.find_by_slug(params[:slug])
  end

  def course_params
    params.require(:course).permit(:title, :price, :description, :repo, :slug, :intro, :cover, :poster)
  end

end
