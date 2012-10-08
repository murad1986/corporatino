# encoding: UTF-8
class AbonentPaymentsController < ApplicationController
  #before_filter :authenticate_user!
  # GET /abonent_payments
  # GET /abonent_payments.json
  def index
    @page_header = "Список пополнений"
    @abonent_payments = AbonentPayment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @abonent_payments }
    end
  end

  # GET /abonent_payments/1
  # GET /abonent_payments/1.json
  def show
    @abonent_payment = AbonentPayment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @abonent_payment }
    end
  end

  # GET /abonent_payments/new
  # GET /abonent_payments/new.json
  def new

    @page_header = "Пополнение абонентского номера"
    @corporations = current_user.admin? ? Corporation.all : current_user.corporations
    @abonent_payment = AbonentPayment.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @abonent_payment }
    end
  end

  def create
    @abonent_payment = AbonentPayment.new(params[:abonent_payment])
    respond_to do |format|
      if @abonent_payment.save
        format.html { redirect_to abonent_payments_path, notice: 'abonent_payment was successfully created.' }
        format.json { render json: @abonent_payments, status: :created, location: @abonent_payment }
      else
        format.html { render action: "new" }
        format.json { render json: @abonent_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /abonent_payments/1/edit
  def edit
    @corporations = current_user.admin? ? Corporation.all : current_user.corporations
    @abonent_payment = AbonentPayment.find(params[:id])
  end

  def check
    # if current_user.admin?
      corporation_phone = params[:corporation_phone]
      phone = params[:phone]
      

      #if Corporation.where(:phone => corporation_phone).first
        if Abonent.where(:phone => phone).first 
          result = 0
        else
          result = 6  # => Абонент не найден
        end
      #else
        #result = 7
      #end
      
      @pay = {
        :command => "check",
        :date => DateTime.current,
        :corporation_phone => corporation_phone,
        :phone => phone,
        :amount => params[:amount],
        :result => result
        }

      respond_to do |format|
        format.xml { render xml: @pay }
      end
      # else
      #   redirect_to :root        
      # end
  end

  def pay
    # if current_user.admin?
      phone = params[:phone]
      amount = params[:amount]
      corporation_phone = params[:corporation_phone]
      platika_id = params[:platika_id]

      
      if abonent_id = Abonent.where(:phone => params[:phone]).first.try(:id)
          @abonent_payment = AbonentPayment.new(
              :abonent_id => abonent_id, 
              :amount => amount, 
              :platika_id => platika_id
          )
          
          if !AbonentPayment.where(:platika_id => platika_id).first # => Проверка на наличие платежа с таким id в базе
            if @abonent_payment.save
              result = 0  # => Результат успешный 
              pay_id = @abonent_payment.id 
            else
              result = 1  # => Ошибка платежа (Не удалось сохранить в базу)
              pay_id = 0
            end
          else
            payment = AbonentPayment.where(:platika_id => platika_id).first
            result = 0    # => Платеж с таким id_platika уже есть в системе
            pay_id = payment.id
            date = payment.created_at


          end
      else
        result = 6      # => Абонент не найден
        pay_id = 0
      end

      @pay = {
        :command => "pay",
        :date => date ? date : Date.current,
        :platika_id => platika_id,
        :pay_id => pay_id,
        :corporation_phone => corporation_phone,
        :phone => phone,
        :amount => params[:amount],
        :result => result
        }

      respond_to do |format|
          format.xml { render xml: @pay, status: :created, location: @abonent_payment }
      end
    # else
    #   redirect_to :root        
    #  end
  end
  # POST /abonent_payments
  # POST /abonent_payments.json

  # PUT /abonent_payments/1
  # PUT /abonent_payments/1.json


  def inback
  # if current_user.admin?
    platika_id = params[:platika_id]
    phone = params[:phone]
    amount = params[:amount]
    corporation_phone = params[:corporation_phone]

    if !AbonentPayment.where(:platika_id => platika_id).first.nil?
          @abonent_payment = AbonentPayment.where(:platika_id => platika_id).first

            if @abonent_payment.created_at.to_date == Date.current
              if @abonent_payment.destroy
                result = 0
              else
                result = 3  # => Операция удаления не прошла
                pay_id = 0
              end
            else
              result = 0
              pay_id = 0
            end
    else
      result = 5      # => Платежа с таким platika_id нет в биллинге
      pay_id = 0
    end

    @pay = {
      :command => "inback",
      :date => DateTime.current,
      :platika_id => platika_id,
      :corporation_phone => corporation_phone,
      :phone => phone,
      :amount => params[:amount],
      :result => result
      }

    respond_to do |format|
        format.xml { render xml: @pay, status: :created, location: @abonent_payment }
    end
  #   else
  #   redirect_to :root
  # end
            
  end

end
