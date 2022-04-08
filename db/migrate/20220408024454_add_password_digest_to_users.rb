class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pasword_digest, :string
    add_column :users, :string, :string
  end
end
