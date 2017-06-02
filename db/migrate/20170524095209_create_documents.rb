class CreateDocuments < ActiveRecord::Migration[5.0]
  def self.up
    create_table :documents do |t|
      t.string :path
      t.string :title
      t.references :user
      t.timestamps
    end
    add_index(:documents, :path, unique: true)
  end

  def self.down
    drop_table :documents
  end
end
