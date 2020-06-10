class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
    @genres = Genre.all
    @song.notes.build
    @song.notes.build
    @song.notes.build
  end

  def create
    #  byebug
    artist = Artist.find_or_create_by(name: song_params[:artist_name])
    # note = Note.create(content: song_params[:note_contents], song_id: song_params)
    song = artist.songs.build(song_params)
    # note = song.notes.build(:content => song_params[:note_contents])
    # note.save
    if song.save
      redirect_to song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    # params.require(:song).permit(:title, :artist_name, :genre_id, :note_contents)
    params.require(:song).permit(:title, :artist_name, :genre_id, :note_contents => [])
  end
end

