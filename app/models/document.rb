class Document < ApplicationRecord
  belongs_to :user

  attr_accessor :doc
  before_save :set_params
  after_save :upload_file
  after_destroy :delete_file

  validates_presence_of :user_id
  validates_presence_of :path
  validates_uniqueness_of :path
  validates_presence_of :title

  def set_params
    return false if @uploaded_file.nil?
    name = File.basename(@uploaded_file.original_filename)
    hash = DateTime.now.strftime("%Q")
    hashed_name = "#{hash}_#{name}"
    dir = "documents/"
    Dir.mkdir(dir) unless File.exists?(dir)
    self.path =  File.join(dir, hashed_name)
  end

  # def self.save_to_disk(file_details)
  #   return false if doc_params.nil?
  #   name = File.basename(doc_params.original_filename)
  #   hash = DateTime.now.strftime("%Q")
  #   hashed_name = "#{hash}_#{name}"
  #   dir = "documents/"
  #   Dir.mkdir(dir) unless File.exists?(dir)
  #   return File.join(dir, hashed_name)
  #   binding.pry
  # end


  def import_upload( upload )
    @uploaded_file = upload
  end

  def upload_file
    File.open(self.path, "wb") { |f| f.write(@uploaded_file.read) }
  end

  def delete_file
    File.delete(self.path) if File.exists?(self.path)
  end
end
