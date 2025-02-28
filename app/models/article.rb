# == Schema Information
#
# Table name: articles
#
#  id                    :integer          not null, primary key
#  author                :string(255)
#  guid                  :string(255)      not null
#  is_posted_to_bluesky  :boolean          default(FALSE)
#  is_posted_to_mastodon :boolean          default(FALSE)
#  link                  :string(255)      not null
#  published_at          :datetime         not null
#  title                 :string(500)      not null
#  created_at            :datetime
#  publisher_id          :integer          not null
#
# Foreign Keys
#
#  fk_article  (publisher_id => publishers.id)
#
class Article < ApplicationRecord
  
  belongs_to :publisher
end
