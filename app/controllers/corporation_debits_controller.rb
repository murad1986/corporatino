# encoding: UTF-8

class CorporationDebitsController < ApplicationController
  # GET /corporation_debits
  # GET /corporation_debits.json
  def index
    @page_header = "Списания с Корпораций"

    @corporation_debits = CorporationDebit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @corporation_debits }
    end
  end

  # GET /corporation_debits/1
  # GET /corporation_debits/1.json
  def show
    @corporation_debit = CorporationDebit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @corporation_debit }
    end
  end

  # GET /corporation_debits/new
  # GET /corporation_debits/new.json
  def new
    @corporation_debit = CorporationDebit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @corporation_debit }
    end
  end

  # GET /corporation_debits/1/edit
  def edit
    @corporation_debit = CorporationDebit.find(params[:id])
  end

  # POST /corporation_debits
  # POST /corporation_debits.json
  def create
    @corporation_debit = CorporationDebit.new(params[:corporation_debit])

    respond_to do |format|
      if @corporation_debit.save
        format.html { redirect_to @corporation_debit, notice: 'Corporation debit was successfully created.' }
        format.json { render json: @corporation_debit, status: :created, location: @corporation_debit }
      else
        format.html { render action: "new" }
        format.json { render json: @corporation_debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /corporation_debits/1
  # PUT /corporation_debits/1.json
  def update
    @corporation_debit = CorporationDebit.find(params[:id])

    respond_to do |format|
      if @corporation_debit.update_attributes(params[:corporation_debit])
        format.html { redirect_to @corporation_debit, notice: 'Corporation debit was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @corporation_debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corporation_debits/1
  # DELETE /corporation_debits/1.json
  def destroy
    @corporation_debit = CorporationDebit.find(params[:id])
    @corporation_debit.destroy

    respond_to do |format|
      format.html { redirect_to corporation_debits_url }
      format.json { head :ok }
    end
  end
end
