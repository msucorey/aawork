class ChangeTableCatRentalRequest < ActiveRecord::Migration
  def change
    remove_index :cat_rental_requests, :user_id
    add_index :cat_rental_requests, :user_id
  end
end
