class Metadata < ApplicationRecord
  belongs_to :congress_member, foreign_key: :pp_member_id, primary_key: :pp_member_id
end
