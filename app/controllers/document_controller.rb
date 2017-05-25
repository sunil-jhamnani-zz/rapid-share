class DocumentController < ApplicationController

  def index
    if current_user
      @documents = current_user.document
    else
      redirect_to '/login'
    end
  end

  def new
    @document = Document.new
  end

  def create
    title = params[:document][:title]
    # temp = params[:document][:doc]
    path = Document.set_params(params[:document][:doc])
    @document = current_user.document.build(:path => path, :title => title)
    if @document.save
      File.open(path, "wb") { |f| f.write(params[:document][:doc].read) }
      flash[:notice] = "Document uploaded successfully!"
      redirect_to root_url
    else
      flash[:error] = "Document upload failed! Please try again"
      redirect_to document_new_path
    end
  end

  def show
    document = Document.find_by_id(params[:id])
    if document
      path = document.path
      File.open(path, "r") {
        |f|
        send_data f.read
      }
    else
      flash[:error] = "No such file"
      redirect_to root_url
    end
  end

  def destroy
    if document = Document.find_by_id(params[:id])
      if document.user_id == session[:user_id]
        Document.destroy(params[:id])

        flash[:notice]="File deleted"
      else
        flash[:notice]="You do not own this file"
      end
    else
      flash[:notice]="No such file"
    end
    redirect_to root_url
  end
end
