class ModifyUsers < ActiveRecord::Migration

  def change
    add_column :users, :user_type, :string
    add_column :listings, :is_approved, :boolean

    execute <<-SQL
      update users
      set user_type='User::Curator';
    SQL

    execute <<-SQL
      update listings
      set is_approved=1;
    SQL
  end

end