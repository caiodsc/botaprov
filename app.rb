# Encoding: utf-8
require 'sinatra'
require 'mongoid'
require 'roar/json/hal'
require 'json'
require 'sinatra/config_file'

Dir["./app/models/*.rb"].each {|file| require file }
Dir["./app/services/**/*.rb"].each {|file| require file }

configure do
  Mongoid.load!("config/mongoid.yml", settings.environment)
  set :server, :puma # default to puma for performance
end

class App < Sinatra::Base
  register Sinatra::ConfigFile
  config_file './config/config.yml'

  get '/' do
    settings.app_secret

  end

  get '/products2' do
    products = Product.all.order_by(:created_at => 'desc')
    ProductRepresenter.for_collection.prepare(products).to_json
  end

  get 'product/:id' do
    product = Product.where(name: 'Joao')
    ProductRepresenter.for_collection.prepare(product).to_json
  end

  post '/produto' do
    name = 'Joao2'
    #params[:name]

    if name.nil? or name.empty?
      halt 400, {:message=>"name field cannot be empty"}.to_json
    end

    product = Product.new(:name=>name)
    if product.save
      [201, product.extend(ProductRepresenter).to_json]
    else
      [500, {:message=>"Failed to save product"}.to_json]
    end
  end

  get '/products' do
    name = 'Caio'
        #params[:name]

    if name.nil? or name.empty?
      halt 400, {:message=>"name field cannot be empty"}.to_json
    end

    product = Product.new(:name=>name)
    if product.save
      [201, product.extend(ProductRepresenter).to_json]
    else
      [500, {:message=>"Failed to save product"}.to_json]
    end
  end
end