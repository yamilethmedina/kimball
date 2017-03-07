class AddReferralToPeople < ActiveRecord::Migration
  def change
    add_column :people, :referral, :string
  end
end
