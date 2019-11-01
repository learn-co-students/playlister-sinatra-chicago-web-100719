require 'rack-flash'
class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash
    
    get '/songs' do
        @songs = Song.all
        erb :"songs/index"
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :"songs/new"
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @artist = @song.artist
        @genres = Genre.all
        erb :"songs/edit"
    end
    
    patch '/songs/:slug' do
        puts @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])
        @song.artist_id = Artist.find_or_create_by(name: params[:artist][:name]).id
        @song.genre_ids = params[:genres]
        @song.save

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"

    end


    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @artist = @song.artist
        @genres = @song.genres
        erb :"songs/show"
    end

    delete '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @song.delete
        redirect '/songs'
    end

    patch '/songs/:slug' do
        puts @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])
        @song.artist_id = Artist.find_or_create_by(name: params[:artist][:name]).id
        @song.genre_ids = params[:genres]
        @song.save

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"

    end

  

    post '/songs' do
        @artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song = Song.find_or_create_by(name: params[:song][:name], artist_id: @artist.id)
        puts @song.artist
        params[:genres].each do |genre|
            Genre.find(genre)
            SongGenre.find_or_create_by(song_id: @song.id, genre_id: genre)
        end
        @genres = @song.genres
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end
end