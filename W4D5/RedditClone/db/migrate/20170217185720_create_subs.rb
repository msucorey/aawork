class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.text :description
      t.integer :user_id, null: false

      t.timestamps null: false
    end
    add_index :subs, :user_id
  end
end

# A Sub is a topic-specific subforum to which users submit a Post.
# Start by writing a Sub model and SubsController. The Sub should have
#  title and description attributes and a moderator association. The
#  cr eator of the Sub is the moderator.
#
# Write all the standard seven routes for SubsController. You can leave
# out destroy if you like.
#
# Write an edit route where the moderator is allowed to update the title
# and description. Use a before_action to prohibit non-moderators from editing or updating the Sub.
#
# The point of a Sub is for users to share posts. A Post should consist of:
#
# A title attribute (required)
# A url attribute (optional)
# A content attribute for content text (optional)
# A sub association to the Sub the Post is submitted to (required)
# An author association.
