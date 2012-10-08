# encoding: UTF-8
class AbonentSaldosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_corporations, only: [:index, :recalc]

  def index
    @page_header = "Взаиморасчеты абонентов Корпорации"

    if (params[:corporation])
      @abonent_id = params[:corporation][:abonent_id]
      @from_day = params[:from_day]
      @to_day = params[:to_day]
      @abonent_saldos = AbonentSaldo.saldos(@abonent_id, @from_day, @to_day)
    else
      @abonent_saldos = []
    end    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @abonent_saldos }
    end
  end

  def recalc
    @corporation = params[:corporation][:corporation_id]
    @from_day = params[:from_day]
    @to_day = params[:to_day]

    AbonentSaldo.recalc(@corporation, @from_day, @to_day)
  end

  def find_corporations
    @corporations = current_user.admin? ? Corporation.all : current_user.corporations
  end

end
