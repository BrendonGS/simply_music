class Api::ChordsController < ApplicationController

  def index
    @chords = Chords.all
    render 'index.json.jbuilder'
  end

  def create
    @chord = Chord.new(
                      song_id: params[:song_id],
                      order: params[:order],
                      beats: params[:beats],
                      quality: params[:quality],
                      inversion: params[:inversion]
                      )
    if @chord.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @chord.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @chord = chord.find(params[:id])
    render 'show.json.jbuilder'
  end

  def update
  @product.song_id = params[:song_id] || @product.song_id
  @product.order = params[:order] || @product.order
  @product.beats = params[:beats] || @product.beats
  @product.quality = params[:quality] || @product.quality
  @product.inversion = params[:inversion] || @product.inversion
  @product.substitution = params[:substitution] || @product.substitution
  @product.seventh = params[:seventh] || @product.seventh
  @product.ninth = params[:ninth] || @product.ninth
    
  end

  def destroy
    @chord = chord.find(params[:id])
    render json: {message: "Terminated."}
  end
end
