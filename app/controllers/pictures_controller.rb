require 'net/http'

class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

    # GET /pictures
    # GET /pictures.json
    def index
      @pictures = Picture.all
    end

    # GET /pictures/1
    # GET /pictures/1.json


    def file_exists?(a)
      url = URI.parse(a)
      req = Net::HTTP.new(url.host, url.port)
      req.use_ssl = true
      res = req.request_head(url.path)
      res.code == '200'
    end



    def show 
      picture = Picture.find(params[:id])

          if picture && file_exists?(picture.attachment.url)
           data = open(picture.attachment.url).read    
            picture.save
             send_data data, :type => picture.attachment, :filename => picture.name

          elsif picture && file_exists?(picture.mirror_attachment.url)
           data = open(picture.mirror_attachment.url).read    
            picture.save
             send_data data, :type => picture.mirror_attachment, :filename => picture.name

          else
           redirect_to @picture, notice: 'error, there is no file in bucket.'
          end
    end
=begin
   def download
      @picture = Picture.find(params[:id])

        if picture && file_exists?(picture.attachment.url)
         data = open(picture.attachment.url).read    
          picture.save
           send_data data, :type => picture.attachment, :filename => picture.name

        if picture && file_exists?(picture.mirror_attachment.url)
         data = open(picture.mirror_attachment.url).read    
          picture.save
           send_data data, :type => picture.mirror_attachment, :filename => picture.name

        else
         redirect_to @picture, notice: 'error, there is no file in bucket.'
        end
        
      end

    end

=end


    


    # GET /pictures/new
    def new
      @picture = Picture.new
    end

    # GET /pictures/1/edit
    def edit
    end

    # POST /pictures
    # POST /pictures.json
    def create

      @picture = Picture.new(picture_params)
      @picture.mirror_attachment = @picture.attachment

      respond_to do |format|
        if @picture.save

          format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
          format.json { render :show, status: :created, location: @picture }
        else
          format.html { render :new }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /pictures/1
    # PATCH/PUT /pictures/1.json
    def update
      respond_to do |format|
        if @picture.update(picture_params)
          format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
          format.json { render :show, status: :ok, location: @picture }
        else
          format.html { render :edit }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /pictures/1
    # DELETE /pictures/1.json
    def destroy
      @picture.destroy
      respond_to do |format|
        format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_picture
        @picture = Picture.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def picture_params
        params.require(:picture).permit(:attachment, :name, :mirror_attachment, :file_extension)
      end
end
