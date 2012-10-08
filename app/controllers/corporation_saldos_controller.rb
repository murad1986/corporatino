# encoding: UTF-8

class CorporationSaldosController < ApplicationController
  # GET /corporation_saldos
  # GET /corporation_saldos.json
  def index
    @page_header = "Взаиморасчеты Корпораций"
    if (params[:corporation])
      @corporation_id = params[:corporation][:corporation_id]
      @from_day = params[:from_day]
      @to_day = params[:to_day]
      @corporation_saldos = CorporationSaldo.saldos(@corporation_id, @from_day, @to_day)
    else
      @corporation_saldos = []
    end    






    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @corporation_saldos }
    end
  end

  # GET /corporation_saldos/1
  # GET /corporation_saldos/1.json
  def show
    @corporation_saldo = CorporationSaldo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @corporation_saldo }
    end
  end

  # GET /corporation_saldos/new
  # GET /corporation_saldos/new.json
  def new
    @corporation_saldo = CorporationSaldo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @corporation_saldo }
    end
  end

  # GET /corporation_saldos/1/edit
  def edit
    @corporation_saldo = CorporationSaldo.find(params[:id])
  end

  # POST /corporation_saldos
  # POST /corporation_saldos.json
  def create
    @corporation_saldo = CorporationSaldo.new(params[:corporation_saldo])

    respond_to do |format|
      if @corporation_saldo.save
        format.html { redirect_to @corporation_saldo, notice: 'Corporation saldo was successfully created.' }
        format.json { render json: @corporation_saldo, status: :created, location: @corporation_saldo }
      else
        format.html { render action: "new" }
        format.json { render json: @corporation_saldo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /corporation_saldos/1
  # PUT /corporation_saldos/1.json
  def update
    @corporation_saldo = CorporationSaldo.find(params[:id])

    respond_to do |format|
      if @corporation_saldo.update_attributes(params[:corporation_saldo])
        format.html { redirect_to @corporation_saldo, notice: 'Corporation saldo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @corporation_saldo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corporation_saldos/1
  # DELETE /corporation_saldos/1.json
  def destroy
    @corporation_saldo = CorporationSaldo.find(params[:id])
    @corporation_saldo.destroy

    respond_to do |format|
      format.html { redirect_to corporation_saldos_url }
      format.json { head :ok }
    end
  end
end
