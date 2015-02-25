class CommentsController < ApplicationController
  def create
    comment = find_commentable.comments.build(comment_params)
    comment.update_attributes(user: current_user)
    comment.save
    redirect_to :back
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end
