class BudgetApp < Sinatra::Base

  [:models].each do |dir|
    Dir[File.dirname(__FILE__) + "/#{dir}/*"].each { |f| require f }
  end

  enable :sessions

  configure do
    use Rack::MethodOverride

    # Use SSL Enforcer
    # use Rack::SslEnforcer, only_hosts: ENV.fetch('BASE_DOMAIN')
    # set :session_secret, ENV.fetch('SESSION_SECRET')

    # Load Mongoid
    Mongoid.load! 'mongoid.yml'
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

    def username
      return session[:username]
    end

    def authenticate!
      redirect '/login' unless logged_in?
    end
  end



  get '/' do
    authenticate!
    erb :index
  end

  get '/login' do
    redirect '/' if logged_in?
    erb :login
  end

  post '/login' do
    if (params[:username] == "danny" && params[:password] == ENV['PASSWORD_DANNY']) || (params[:username] == "laurence" && params[:password] == ENV['PASSWORD_LAURENCE'])
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

  post '/tx/:user' do |user|
    halt(401, { message: "Unathorized"}.to_json) unless params[:token] == ENV['WEBHOOK_AUTH_TOKEN']
    data = JSON.parse(request.body.read)["data"]
    Transaction.make user, data
  end
end
