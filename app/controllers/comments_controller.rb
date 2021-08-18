class CommentsController < ApplicationController

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
  
    private

  end
  