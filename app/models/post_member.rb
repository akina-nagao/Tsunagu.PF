class PostMember < ApplicationRecord
  belongs_to :post
  belongs_to :customer
  
  enum status: { applying: 0, permitted: 1, excluded: 2 }
end
