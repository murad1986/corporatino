# encoding: UTF-8
class RateCorposController < ApplicationController
  before_filter :authenticate_user!
  # GET /rate_corpos
  # GET /rate_corpos.json
  def index
    @page_header = "Тарифы для Корпораций"
    @rate_corpos = RateCorpo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rate_corpos }
    end
  end

  # GET /rate_corpos/1
  # GET /rate_corpos/1.json
  def show
    @rate_corpo = RateCorpo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rate_corpo }
    end
  end

  # GET /rate_corpos/new
  # GET /rate_corpos/new.json
  def new
     @page_header = "Новый Тариф"
    @rate_corpo = RateCorpo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rate_corpo }
    end
  end

  # GET /rate_corpos/1/edit
  def edit
     @page_header = "Редактирование Тарифа"
    @rate_corpo = RateCorpo.find(params[:id])
  end

  # POST /rate_corpos
  # POST /rate_corpos.json
  def create
    @rate_corpo = RateCorpo.new(params[:rate_corpo])

    respond_to do |format|
      if @rate_corpo.save
        format.html { redirect_to @rate_corpo, notice: 'Rate corpo was successfully created.' }
        format.json { render json: @rate_corpo, status: :created, location: @rate_corpo }
      else
        format.html { render action: "new" }
        format.json { render json: @rate_corpo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rate_corpos/1
  # PUT /rate_corpos/1.json
  def update
    @rate_corpo = RateCorpo.find(params[:id])

    respond_to do |format|
      if @rate_corpo.update_attributes(params[:rate_corpo])
        format.html { redirect_to @rate_corpo, notice: 'Rate corpo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @rate_corpo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rate_corpos/1
  # DELETE /rate_corpos/1.json
  def destroy
    @rate_corpo = RateCorpo.find(params[:id])
    @rate_corpo.destroy

    respond_to do |format|
      format.html { redirect_to rate_corpos_url }
      format.json { head :ok }
    end
  end
end
