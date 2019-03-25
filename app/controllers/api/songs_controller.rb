class Api::SongsController < ApplicationController
  before_action :authenticate_user 
  
  def index
    @songs = current_user.songs
    render 'index.json.jbuilder'
  end

  def create
    @song = Song.new(
                        user_id: current_user.id,
                        title: params[:title],
                        artist: params[:artist],
                        lyrics: params[:lyrics],
                        beats_per_measure: params[:beats_per_measure],
                        note_value: params[:note_value]
                      )
    if @song.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @song.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @song = Song.find(params[:id])
    render 'show.json.jbuilder'
  end

  def update
    @song = Song.find(params[:id])

    @song.user_id = params[:user_id] || @song.user_id
    @song.title = params[:title] || @song.title
    @song.artist = params[:artist] || @song.artist
    @song.lyrics = params[:lyrics] || @song.lyrics
    @song.beats_per_measure = params[:beats_per_measure] || @song.beats_per_measure
    @song.note_value = params[:note_value] || @song.note_value

    if @song.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @song.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    song = Song.find(params[:id])
      song.destroy
      render json: {message: "Obliterated"}
  end
end
