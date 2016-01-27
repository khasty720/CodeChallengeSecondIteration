class PatternsController < ApplicationController
  before_action :set_pattern, only: [:show, :edit, :update, :destroy]
  before_action :authenticate

  def index
    @patterns = Pattern.all
  end

  def new
    @pattern = Pattern.new
  end

  def edit
  end

  def create
    @pattern = Pattern.new(pattern_params)

    respond_to do |format|
      if @pattern.save
        format.html { redirect_to patterns_path, notice: 'Pattern was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @pattern.update(pattern_params)
        format.html { redirect_to patterns_path, notice: 'Pattern was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @pattern.destroy
    respond_to do |format|
      format.html { redirect_to patterns_url, notice: 'Pattern was successfully destroyed.' }
    end
  end

  private
    def set_pattern
      @pattern = Pattern.find(params[:id])
    end

    def pattern_params
      params.require(:pattern).permit(:score_pattern, :description, :weight_id)
    end
end
