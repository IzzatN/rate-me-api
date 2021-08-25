class CommentsController < ApplicationController
  skip_before_action :authenticate

  def index
    comments = Comment.all

    if params[:service_id]
      comments = comments.where(service_id: params[:service_id])
    end

    render json: CommentSerializer.new(comments).serializable_hash
  end

  def show
    comment = Comment.find(params[:id])

    if comment
      render json: CommentSerializer.new(comment).serializable_hash
    else
      data = { errors: [status: 404, code: 'NotFound', detail: "Record not found"] }
      render json: data, status: :not_found
    end
  end

  def create
    comment = Comment.new(create_params)

    if comment.save
      render json: CommentSerializer.new(comment).serializable_hash
    else
      data = { errors: [status: 422, code: 'UnprocessableEntity', details: comment.errors.messages] }
      render json: data, status: :unprocessable_entity
    end
  end

  # def update
  #   comment = Comment.find(params[:id])

  #   unless current_user.id == comment.user.id
  #     return send_forbidden
  #   end

  #   if comment.update(create_params)
  #     render json: CommentSerializer.new(comment).serializable_hash
  #   else
  #     data = { errors: [ status: 422, code: 'UnprocessableEntity', detail: comment.errors.messages ] }
  #     render json: data, status: :unprocessable_entity
  #   end
  # end

  # ishlavuradi
  def destroy
    comment = Comment.find(params[:id])

    comment.destroy
    render json: {}, status: :no_content
  end

  private

  def create_params
    comment = params[:data].require(:attributes).permit(
      :text,
      :user,
      :service
    )

    if data = params.dig(:data, :relationships, :service, :data)
      comment[:service_id] = data[:id]
    end

    if data = params.dig(:data, :relationships, :user, :data)
      comment[:user_id] = data[:id]
    end

    comment
  end
end





