class AddCompanyIdToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :company_id, :integer
  end
end
