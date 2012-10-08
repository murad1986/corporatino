# encoding: UTF-8

class CorporationPaymentsController < ApplicationController
  # GET /corporation_payments
  # GET /corporation_payments.json
  def index
    @page_header = "Пополнения Корпораций"
    @corporation_payments = CorporationPayment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @corporation_payments }
    end
  end

  # GET /corporation_payments/1
  # GET /corporation_payments/1.json
  def show
    @page_header = "Пополнения Корпораций"
    @corporation_payment = CorporationPayment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @corporation_payment }
    end
  end

  # GET /corporation_payments/new
  # GET /corporation_payments/new.json
  def new
    @page_header = "Новое пополнение"
    @corporation_payment = CorporationPayment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @corporation_payment }
    end
  end

  # GET /corporation_payments/1/edit
  def edit
    @corporation_payment = CorporationPayment.find(params[:id])
  end

  # POST /corporation_payments
  # POST /corporation_payments.json
  def create
    @corporation_payment = CorporationPayment.new(params[:corporation_payment])

    respond_to do |format|
      if @corporation_payment.save
        format.html { redirect_to @corporation_payment, notice: 'Corporation payment was successfully created.' }
        format.json { render json: @corporation_payment, status: :created, location: @corporation_payment }
      else
        format.html { render action: "new" }
        format.json { render json: @corporation_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /corporation_payments/1
  # PUT /corporation_payments/1.json
  def update
    @corporation_payment = CorporationPayment.find(params[:id])

    respond_to do |format|
      if @corporation_payment.update_attributes(params[:corporation_payment])
        format.html { redirect_to @corporation_payment, notice: 'Corporation payment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @corporation_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corporation_payments/1
  # DELETE /corporation_payments/1.json
  def destroy
    @corporation_payment = CorporationPayment.find(params[:id])
    @corporation_payment.destroy

    respond_to do |format|
      format.html { redirect_to corporation_payments_url }
      format.json { head :ok }
    end
  end
end
