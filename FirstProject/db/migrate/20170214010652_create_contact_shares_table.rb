class CreateContactSharesTable < ActiveRecord::Migration
  def change
    create_table :contact_shares do |t|
      t.integer :contact_id, null: false
      t.integer :user_id, null:false

      t.timestamps
    end
    add_index :contact_shares, :contact_id, :unique => true
    add_index :contact_shares, :user_id, :unique => true
  end
end

# ContactShare
# Columns:
# contact_id
# user_id
# Ensure that both are present. Add the two levels of
# validations/constraints.
# Ensure that a user cannot have a single Contact shared with them more
# than once. Add two levels of validation/constraint.
# Add indices to ContactShare's foreign key columns for fast lookup.
# NB: we almost always want to create indexes for any foreign keys,
# particularly if those foreign keys will be used in a has_many or a
# has_one relationship.
