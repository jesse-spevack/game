class Impersonation < ApplicationRecord
  belongs_to :impersonator, class_name: "User", foreign_key: "impersonator_id"
  belongs_to :impersonatee, class_name: "User", foreign_key: "impersonatee_id"
end
