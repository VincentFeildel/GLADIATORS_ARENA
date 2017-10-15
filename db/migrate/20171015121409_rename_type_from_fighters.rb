class RenameTypeFromFighters < ActiveRecord::Migration[5.1]
  def change
    rename_column :fighters, :type, :type_gladiator
  end
end
