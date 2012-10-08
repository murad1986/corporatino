# encoding: UTF-8
class AbonentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @page_header = "Список Абонентов Корпорации"

      if params[:corporation] 
        c_id = params[:corporation][:corporation_id]
        corp_id = c_id if current_user.corporations.include?(Corporation.find_by_id(c_id)) || current_user.admin? 
      else
        corp_id =  -1
      end

      @abonents = Abonent.find_all_by_corporation_id(corp_id)

    respond_to do |format|
      format.html
      format.json { render json: @abonents }
      format.xml { render xml: @abonents }
    end
  end

  def show
    @abonent = Abonent.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @abonent }
    end
  end

  def new
    @page_header = "Добавление нового абонента"

    @abonent = Abonent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @abonent }
    end
  end

  def edit
    @page_header = "Редактирование абонента"
    @abonent = Abonent.find(params[:id])
  end

  def create
    @abonent = Abonent.new(params[:abonent])

    respond_to do |format|
      if @abonent.save
        format.html { redirect_to abonents_path, notice: 'Abonent was successfully created.' }
        format.json { render json: @abonent, status: :created, location: @abonent }
      else
        format.html { render action: "new" }
        format.json { render json: @abonent.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @abonent = Abonent.find(params[:id])

    respond_to do |format|
      if @abonent.update_attributes(params[:abonent])
        format.html { redirect_to abonents_path, notice: 'Abonent was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @abonent.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @abonent = Abonent.find(params[:id])
    @abonent.destroy

    respond_to do |format|
      format.html { redirect_to abonents_url }
      format.json { head :ok }
    end
  end

end
