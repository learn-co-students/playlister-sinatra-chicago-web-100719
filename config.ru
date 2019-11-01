require './config/environment'

begin
  fi_check_migration

  enable :sessions

  use Rack::MethodOverride
  use GenresController
  use SongsController
  use ArtistsController
  run ApplicationController
rescue ActiveRecord::PendingMigrationError => err
  STDERR.puts err
  exit 1
end
