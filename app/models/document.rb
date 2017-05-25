class Document < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :path
  validates_uniqueness_of :path
  validates_presence_of :title

  def self.set_params(doc_params)
    return false if doc_params.nil?
    name = File.basename(doc_params.original_filename)
    hash = DateTime.now.strftime("%Q")
    hashed_name = "#{hash}_#{name}"
    dir = "documents/"
    Dir.mkdir(dir) unless File.exists?(dir)
    return File.join(dir, hashed_name)
  end

end
