class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comment_counter
  after_destroy :decrement_comment_counter

  def update_comment_counter
    post.update(comments_counter: post.comments.all.length)
  end

  def decrement_comment_counter
    post.decrement!(:comments_counter)
  end

  private :update_comment_counter, :decrement_comment_counter
end
