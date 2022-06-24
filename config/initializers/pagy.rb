require 'pagy/extras/headers'
require 'pagy/extras/overflow'

Pagy::DEFAULT[:items]  = 5
Pagy::DEFAULT[:overflow] = :last_page