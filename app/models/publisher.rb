# == Schema Information
#
# Table name: publishers
#
#  id   :integer          not null, primary key
#  name :string(500)      not null
#
class Publisher < ApplicationRecord
  
  def articles
    Article.find_by_sql(
        "
          SELECT a.*, p.name AS publisher_name
          FROM articles a, publishers p
          WHERE a.publisher_id = p.id
          AND p.id = #{self.id}
          ORDER BY a.published_at DESC
        "
      )
  end
end
