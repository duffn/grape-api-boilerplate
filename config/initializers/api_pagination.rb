# frozen_string_literal: true

ApiPagination.configure do |config|
  config.paginator = :kaminari # or :will_paginate
  config.include_total = false
end
