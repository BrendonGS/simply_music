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
    @chord = Chord.find(params[:id])
    render 'show.json.jbuilder'
  end

  def update
    @chord = Chord.find(params[:id])

    @chord.beats = params[:beats] || @chord.beats
    @chord.quality = params[:quality] || @chord.quality
    @chord.inversion = params[:inversion] || @chord.inversion

    @chord.save

    render "show.json.jbuilder"
  end

  def destroy
    @chord = Chord.find(params[:id])
    @chord.destroy
    render json: {message: "Terminated."}
  end
end
