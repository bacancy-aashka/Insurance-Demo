class CallbackInformation < ApplicationRecord
  belongs_to :quotation, optional: true

  enum call_availabilities: ['AM', 'Between 11AM and 1PM', 'PM', 'Between 4PM and 6:30PM']
end
