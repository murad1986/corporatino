class AbonentTarif < ActiveRecord::Base
  has_many   :abonents
  has_many   :abonent_debits
  belongs_to :user
end
