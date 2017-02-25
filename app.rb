class BudgetApp < Sinatra::Base

  [:models].each do |dir|
    Dir[File.dirname(__FILE__) + "/#{dir}/*"].each { |f| require f }
  end

  configure do
    use Rack::MethodOverride

    # Use SSL Enforcer
    # use Rack::SslEnforcer, only_hosts: ENV.fetch('BASE_DOMAIN')
    set :session_secret, ENV.fetch('SESSION_SECRET')

    # Enable sinatra sessions
    use Rack::Session::Cookie, key: '_rack_session',
                               path: '/',
                               expire_after: 2_592_000, # In seconds
                               secret: settings.session_secret

    # Load Mongoid
    Mongoid.load! 'mongoid.yml'
    Mongoid.raise_not_found_error = false
  end

  configure :development do
    require 'awesome_print'
    require 'pry'
    require 'better_errors'
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end

  helpers do
    def logged_in?
      if session[:username].nil?
        return false
      else
        return true
      end
    end

    def logged_in_user
      User.find_by username: session[:username]
    end

    def money(amount, currency)
      Money.new(amount, currency).format
    end

    def authenticate!
      redirect '/login' unless logged_in?
    end
  end

  before do
    @users = User.all
  end


  ################# MAIN ROUTES #################

  get '/' do
    authenticate!
    erb :index
  end

  get '/u/:username' do |username|
    authenticate!
    @user = User.find_by username: username

    if @user
      @transactions = @user.transactions
      erb :transactions
    else
      redirect '/'
    end
  end

  ################# TAG MANAGEMENT ROUTES #################

  get '/tags' do
    authenticate!
    @user = logged_in_user
    @tags = @user.tags
    erb :tags
  end

  post '/tags' do
    authenticate!
    logged_in_user.create_tag params[:tagname]
    redirect '/tags'
  end

  post '/tags/add-to-tx' do
    authenticate!
    tx = Transaction.find(params[:transaction_id])
    tag = Tag.find_by name: params[:tagname]
    if (tx.tags << tag)
      redirect "/u/#{logged_in_user.username}"
    end
  end


  ################# LOGIN ROUTES #################

  get '/login' do
    redirect '/' if logged_in?
    erb :login, layout: false
  end

  post '/login' do
    user = User.find_by username: params[:username]

    if (user && user.password == params[:password])
      session[:username] = params[:username]
      redirect '/'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session[:username] = nil
    redirect '/login'
  end

  ################# HANDLE WEBHOOKS #################

  post '/tx/:username' do |username|
    halt(401, { message: "Unathorized"}.to_json) unless params[:token] == ENV['WEBHOOK_AUTH_TOKEN']
    data = JSON.parse(request.body.read)["data"]
    Transaction.make username, data
    status 201
  end

  ################# DEBUG ROUTES #################

  if ENV['RACK_ENV'] == 'development'
    get '/pry' do
      binding.pry
    end
  end
end
