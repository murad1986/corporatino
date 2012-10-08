# encoding: UTF-8
class AbonentDebitsController < ApplicationController
  before_filter :authenticate_user!

  # GET /abonent_debits
  # GET /abonent_debits.json
  def index
    @page_header = "Списания со счета абонентов"
    @abonent_debits = AbonentDebit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @abonent_debits }
    end
  end

  # GET /abonent_debits/1
  # GET /abonent_debits/1.json
  def show
    @abonent_debit = AbonentDebit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @abonent_debit }
    end
  end

  # GET /abonent_debits/new
  # GET /abonent_debits/new.json
  def new
    @abonent_debit = AbonentDebit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @abonent_debit }
    end
  end

  # GET /abonent_debits/1/edit
  def edit
    @abonent_debit = AbonentDebit.find(params[:id])
  end

  # POST /abonent_debits
  # POST /abonent_debits.json
  def create
    @abonent_debit = AbonentDebit.new(params[:abonent_debit])

    respond_to do |format|
      if @abonent_debit.save
        format.html { redirect_to @abonent_debit, notice: 'Abonent debit was successfully created.' }
        format.json { render json: @abonent_debit, status: :created, location: @abonent_debit }
      else
        format.html { render action: "new" }
        format.json { render json: @abonent_debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /abonent_debits/1
  # PUT /abonent_debits/1.json
  def update
    @abonent_debit = AbonentDebit.find(params[:id])

    respond_to do |format|
      if @abonent_debit.update_attributes(params[:abonent_debit])
        format.html { redirect_to @abonent_debit, notice: 'Abonent debit was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @abonent_debit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /abonent_debits/1
  # DELETE /abonent_debits/1.json
  def destroy
    @abonent_debit = AbonentDebit.find(params[:id])
    @abonent_debit.destroy

    respond_to do |format|
      format.html { redirect_to abonent_debits_url }
      format.json { head :ok }
    end
  end
end
