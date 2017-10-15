class Fighter < ApplicationRecord

  GLAD_TYPES = ["Hoplomaque", "Mirmillon", "Thrace", "Retiaire"]
  validates :type_gladiator, inclusion: {in: GLAD_TYPES}
end
