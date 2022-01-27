class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:destroy, :create]

  def create
    course = Course.find_by(slug: params[:slug])
    @lesson = course.lessons.build(lesson_params)
    @lesson.user = current_user

    if @lesson.save
      v = polymorphic_url(@lesson.video) if @lesson.video.attached?
      lc = polymorphic_url(@lesson.cover.variant(Lesson.large_options)) if @lesson.cover.attached?
      lt = polymorphic_url(@lesson.cover.variant(Lesson.thumbnail_options)) if @lesson.cover.attached?

      lesson = {
        title: @lesson.title,
        video: v,
        cover: lc,
        thumbnail: lt,
        locked: false
      }
      
      render json: lesson, status: :created
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end
  
    def show
    end
  
  
    def update
        if @lesson.update(lesson_params)
          render :show
        else
          render json: @lesson.errors, status: :unprocessable_entity
        end
    end
  
  
    def destroy
      @lesson.destroy
    end
  
    private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end
  
    def lesson_params
      params.require(:lesson).permit(:title, :video, :cover)
    end
end
