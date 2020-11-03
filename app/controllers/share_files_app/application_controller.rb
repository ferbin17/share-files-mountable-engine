module ShareFilesApp
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    rescue_from ActiveRecord::RecordNotFound, with: :not_record_found 
    rescue_from Exception, with: :error
    rescue_from ActionController::RoutingError, with: :not_found
    before_action :find_carousels
    
    def raise_not_found
      raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
    end
  
    def not_found
      flash[:warning] = "Page not found"
      respond_to do |format|
        format.html{ redirect_to :root}
        # format.html { render file: Rails.public_path.join('404.html'), status: :not_found, layout: false }
        format.xml { head :not_found }
        format.any { head :not_found }
      end
    end
    
    def not_record_found
      flash[:warning] = "No record found with ID"
      respond_to do |format|
        format.html { redirect_to :root }
        format.xml { head :not_found }
        format.any { head :not_found }
      end
    end
    
    def error
      flash[:warning] = "Encountered some error. Sorry for the inconvenience"
      respond_to do |format|
        format.html{ redirect_to :root}
        # format.html { render file: Rails.public_path.join('500.html'), status: :not_found, layout: false }
        format.xml { head :not_found }
        format.any { head :not_found }
      end
    end
  
    private
      def find_carousels
        files = Dir.entries("#{ShareFilesApp::Engine.root}/app/assets/images/share_files_app/carousel/")
        @files = files.select{|f| f.split(".").last == "jpg"}.sort
        @text = {}
        if File.exist?("#{ShareFilesApp::Engine.root}/app/assets/images/share_files_app/carousel/carousel.yml")
          @text = YAML.load_file("#{ShareFilesApp::Engine.root}/app/assets/images/share_files_app/carousel/carousel.yml")
        end
      end
  end
end
