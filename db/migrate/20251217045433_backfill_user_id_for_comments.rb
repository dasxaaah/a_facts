class BackfillUserIdForComments < ActiveRecord::Migration[8.1]
  def up
    default_user_id = User.first&.id

    Comment.reset_column_information
    Comment.includes(:post).where(user_id: nil).find_each do |comment|
      comment.update_columns(
        user_id: comment.post&.user_id || default_user_id
      )
    end
  end

  def down
  end
end