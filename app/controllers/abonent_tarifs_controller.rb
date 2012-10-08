# encoding: UTF-8

class AbonentTarifsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @page_header = "Тарифы"
    @abonent_tarifs = current_user.admin? ? AbonentTarif.all : current_user.abonent_tarifs
  end

  def new
    @page_header = "Добавление нового тарифа"
    @abonent_tarif = AbonentTarif.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @abonent_tarif }
    end
  end

  def edit
    @page_header = "Добавление нового тарифа"
    @abonent_tarif = AbonentTarif.find(params[:id])
  end

  def create
    @abonent_tarif = AbonentTarif.new(params[:abonent_tarif])
    @abonent_tarif.user_id = current_user.id
    respond_to do |format|
      if @abonent_tarif.save
        format.html { redirect_to abonent_tarifs_path, notice: 'Abonent tarif was successfully created.' }
        format.json { render json: @abonent_tarif, status: :created, location: @abonent_tarif }
      else
        format.html { render action: "new" }
        format.json { render json: @abonent_tarif.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @abonent_tarif = AbonentTarif.find(params[:id])

    respond_to do |format|
      if @abonent_tarif.update_attributes(params[:abonent_tarif])
        format.html { redirect_to abonent_tarifs_path, notice: 'Abonent tarif was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @abonent_tarif.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @abonent_tarif = AbonentTarif.find(params[:id])
    @abonent_tarif.destroy

    respond_to do |format|
      format.html { redirect_to abonent_tarifs_url }
      format.json { head :ok }
    end
  end
end
