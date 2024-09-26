# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  details    :text
#  hobby      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :hobby, :details
end
