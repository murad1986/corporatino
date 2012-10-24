class AbonentTarif < ActiveRecord::Base
  has_many   :abonents
  has_many   :abonent_debits
  belongs_to :user

  def get_charge
  	if monthly
  		tarif
  	else
  		tarif / 30.0
  	end
  end
end
