# frozen_string_literal: true

# rubocop:disable Style/Documentation

class NewsarticlesController < ApplicationController
  before_action :set_newsarticle, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show top_news all_news]
  before_action :correct_user, only: %i[edit update destroy]


  def all_news
    all_news = HTTParty.get('https://newsapi.org/v2/everything?q=keyword&apiKey=09a2b9ec1565413983e77e80132abc61')
    @articles = JSON.parse(all_news.body)["articles"]
  end
  

  def top_news
    top_news = HTTParty.get('https://newsapi.org/v2/top-headlines?country=us&apiKey=09a2b9ec1565413983e77e80132abc61')
    @articles = JSON.parse(top_news.body)["articles"]
  end
  

  def save
    title = params[:article_id]
    logger.debug "The article id is: #{params[:article_id]}"
    response = HTTParty.get("https://newsapi.org/v2/everything?q=#{title}&apiKey=09a2b9ec1565413983e77e80132abc61")
    logger.debug "The article id is: #{response}"

        begin
          if response.code != 200
            flash[:alert] = "Error: #{response.message}"
            redirect_to root_path
            return
          end
        article_data = JSON.parse(response.body)["articles"][0]
        source_name = article_data["source"].is_a?(Hash) && article_data["source"].has_key?("name") ? article_data["source"]["name"] : "Unknown"
        article_params = {
        source: source_name,
        author: article_data["author"],
        title: article_data["title"],
        text: article_data["description"],
        imglink: article_data["urlToImage"],
        articlelink: article_data["url"],
        user_id: current_user.id
    }
    logger.debug "The article id is: #{article_params}"
    Newsarticle.create(article_params)

    redirect_to root_path, notice: 'Newsarticle saved'
  rescue JSON::ParserError => e
    flash[:alert] = "There was an error parsing the JSON response"
    redirect_to root_path
end
end


  # GET /newsarticles or /newsarticles.json
  def index
    @newsarticles = Newsarticle.all
  end

  # GET /newsarticles/1 or /newsarticles/1.json
  def show; end

  # GET /newsarticles/new
  def new
    @newsarticle = current_user.newsarticles.build
  end

  # GET /newsarticles/1/edit
  def edit; end

  def correct_user
    @newsarticle = current_user.newsarticles.find_by(id: params[:id])
    redirect_to newsarticles_path, notice: 'You are not allowed to edit this article' if @newsarticle.nil?
  end

  # POST /newsarticles or /newsarticles.json
  def create
    @newsarticle = current_user.newsarticles.build(newsarticle_params)

    respond_to do |format|
      if @newsarticle.save
        format.html { redirect_to newsarticle_url(@newsarticle), notice: 'Newsarticle was successfully created.' }
        format.json { render :show, status: :created, location: @newsarticle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @newsarticle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newsarticles/1 or /newsarticles/1.json
  def update
    respond_to do |format|
      if @newsarticle.update(newsarticle_params)
        format.html { redirect_to newsarticle_url(@newsarticle), notice: 'Newsarticle was successfully updated.' }
        format.json { render :show, status: :ok, location: @newsarticle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @newsarticle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newsarticles/1 or /newsarticles/1.json
  def destroy
    @newsarticle.destroy

    respond_to do |format|
      format.html { redirect_to newsarticles_url, notice: 'Newsarticle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_newsarticle
    @newsarticle = Newsarticle.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def newsarticle_params
    params.require(:newsarticle).permit(:source, :author, :title, :text, :imglink, :articlelink, :user_id)
  end
end
