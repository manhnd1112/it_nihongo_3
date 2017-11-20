class Like < ApplicationRecord
  belongs_to :user
  belongs_to :review
  after_create_commit {
    if self.user.id != self.review.user.id
      @notification = Notification.find_or_create_by(
          from_user_id: self.user.id,
          to_user_id: self.review.user.id,
          type: Notification.types[:like],
          review_id: self.review_id,
      )
      puts "===========================\n"
      puts @notification.id
      puts "===========================\n"
      @notification.update_attributes status: Notification.statuses[:not_seen]
      @notification.save
    end
  }
end
