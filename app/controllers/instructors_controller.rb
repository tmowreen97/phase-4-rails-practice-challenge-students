class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  def index 
    instructors = Instructor.all
    render json: instructors, status: :ok
  end
  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  end
  def update
    instructor = Instructor.find(params[:id])
    instructor.update!(instructor_params)
    render json: instructor

  end
  def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy
    head :no_content
  end
  private

  def instructor_params
    params.permit(:name)
  end

  def render_not_found_response
    render json: {errors: "not found"}, status: :not_found
  end 

  def render_unprocessable_entity_response(invalid)
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end
end
