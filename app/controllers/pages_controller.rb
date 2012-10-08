# encoding: UTF-8

class PagesController < ApplicationController
layout "main"
before_filter :authenticate_user!, :except => [:about]

  def index

    # Выводим последние новости

    @news = News.latest.last(5)
    
    # Статистику [Баланс, Кол-во абонентов, Сумма на счету в биллинге]

    @corporation = Corporation.find(current_user.corporation.id)
    

    # Список последних поступлений

    # Список абонентов с приближающейся датой блокировки

  end

  def about
    @page_header = "О нашей компании и предоставляемых услугах"

  end

end
