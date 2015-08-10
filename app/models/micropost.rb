class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  # ファイル用の属性を追加するhas_attached_fileメソッド
  has_attached_file :image, styles: { medium: "200x150>", thumb: "50x50>" }
  #  画像の拡張子を限定するためのvalidatorを定義
  validates_attachment(:image,
      size: { in: 0..2.megabytes },
        content_type: {
          content_type: [
            "image/jpg", "image/jpeg", "image/pjpeg",
            "image/gif",
            "image/png", "image/x-png",
          ]
    })

  # 与えられたユーザーがフォローしているユーザー達のマイクロポストを返す。
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end