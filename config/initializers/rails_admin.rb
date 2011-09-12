
RailsAdmin.config do |config|
  config.authorize_with :cancan

  config.model Post do
    visible false
  end

  config.model Micropost do
    visible false
  end

  config.model Photo do
    list do
      field :post
      field :caption
      field :image do
        thumb_method :medium
      end
      field :updated_at
    end
    show do
      field :post
      field :caption
      field :image
      field :created_at
      field :updated_at
    end
    edit do
      field :post
      field :caption
      field :image
    end
  end

  config.model Vote do
    list do
      field :id
      field :vote do
        pretty_value do
          bindings[:object].vote ? 'UP' : 'DOWN'
        end
      end
      field :voteable
      field :voter
      field :created_at
      field :updated_at
    end
    show do
      group :default do
        field :vote do
          pretty_value do
            bindings[:object].vote ? 'UP' : 'DOWN'
          end
        end
        field :voteable
        field :voter
        field :created_at
        field :updated_at
      end
    end
    edit do
      group :default do
        field :vote do
          label "Vote Up?"
        end
        field :voteable
        field :voter
      end
    end
  end

  config.model Authentication do
    list do
      field :id
      field :user
      field :provider
      field :uid
      field :updated_at
    end
    show do
      field :user
      field :provider
      field :uid
      field :created_at
      field :updated_at
    end
    edit do
      field :user
      field :provider
      field :uid
    end
  end

  config.model College do
    list do
      field :id
      field :conference do
        label "Conf"
      end
      field :name
      field :permalink
      field :smacks_count do
        label "Smacks"
      end
      field :redemptions_count do
        label "Redemptions"
      end
      field :created_at
      field :updated_at
    end
    show do
      field :conference
      field :name
      field :permalink
      field :smacks_count
      field :redemptions_count
      field :created_at
      field :updated_at
    end
    edit do
      field :conference
      field :name
      field :permalink
      field :smacks_count
      field :redemptions_count
    end
  end

  config.model Comment do
    list do
      field :id
      field :user
      field :comment
      field :reports_count
      field :commentable
      field :created_at
      field :updated_at
    end
    edit do
      exclude_fields :title
    end
  end

  config.model Conference do
    list do
      field :id
      field :name
      field :smacks_count
      field :redemptions_count
      field :updated_at
    end
    show do
      field :name
      field :smacks_count
      field :redemptions_count
      field :created_at
      field :updated_at
      field :colleges
    end
  end

  config.model NewsPost do
    list do
      field :id
      field :post
      field :url
      field :created_at
      field :updated_at
    end
    show do
      field :post
      field :url
      field :created_at
      field :updated_at
    end
    edit do
      field :post
      field :url
    end
  end

  config.model Reason do
    show do
      field :reason
      field :created_at
      field :updated_at
    end
  end

  config.model Post do
    list do
      field :id
      field :type
      field :postable
      field :title
      field :reports_count
      field :summary
      field :user
      field :on_frontpage_week
      field :created_at
      field :updated_at
    end
    show do
      group :default do
        field :type
        field :postable
        field :title
        field :summary
        field :reports_count
        field :user
        field :on_frontpage_week
        field :created_at
        field :updated_at
      end
      field :video
      field :photo
      field :news_post
      field :statistic
    end
    edit do
      group :default do
        field :type
        field :postable
        field :title
        field :summary
        field :reports_count
        field :user
        field :on_frontpage_week
      end
      field :video
      field :photo
      field :news_post
      field :statistic
    end
  end

  config.model Redemption do
    list do
      field :id
      field :postable
      field :title
      field :reports_count
      field :summary
      field :user
      field :on_frontpage_week
      field :created_at
      field :updated_at
    end
    show do
      group :default do
        field :postable
        field :title
        field :summary
        field :reports_count
        field :user
        field :on_frontpage_week
        field :created_at
        field :updated_at
      end
      field :video
      field :photo
      field :news_post
      field :statistic
    end
    edit do
      group :default do
        field :postable
        field :title
        field :summary
        field :reports_count
        field :user
        field :on_frontpage_week
      end
      field :video
      field :photo
      field :news_post
      field :statistic
    end
  end

  config.model Smack do
    list do
      field :id
      field :postable
      field :title
      field :reports_count
      field :summary
      field :user
      field :on_frontpage_week
      field :created_at
      field :updated_at
    end
    show do
      group :default do
        field :postable
        field :title
        field :summary
        field :reports_count
        field :user
        field :on_frontpage_week
        field :created_at
        field :updated_at
      end
      field :video
      field :photo
      field :news_post
      field :statistic
    end
    edit do
      group :default do
        field :postable
        field :title
        field :summary
        field :reports_count
        field :user
        field :on_frontpage_week
      end
      field :video
      field :photo
      field :news_post
      field :statistic
    end
  end

  config.model Relationship do
    list do
      field :id
      field :followed
      field :follower
      field :created_at
      field :updated_at
    end
    show do
      field :followed
      field :follower
      field :created_at
      field :updated_at
    end
    edit do
      field :followed
      field :follower
    end
  end

  config.model Report do
    list do
      field :id
      field :reportable
      field :reason
      field :user
      field :custom_reason
      field :created_at
      field :updated_at
    end
    show do
      field :reportable
      field :reason
      field :user
      field :custom_reason
      field :created_at
      field :updated_at
    end
    edit do
      field :reportable
      field :reason
      field :user
      field :custom_reason
    end
  end

  config.model Statistic do
    list do
      field :id
      field :post
      field :name
      field :data
      field :updated_at
    end
    show do
      field :post
      field :name
      field :data
      field :created_at
      field :updated_at
    end
    edit do
      field :post
      field :name
      field :data
    end
  end

  config.model User do
    list do
      exclude_fields :up_votes, :down_votes
    end
    show do
      exclude_fields :up_votes, :down_votes
    end
    edit do
      exclude_fields :up_votes, :down_votes
    end
  end

  config.model Video do
    list do
      field :id
      field :post
      field :url
      field :created_at
      field :updated_at
    end
    show do
      field :post
      field :url
      field :created_at
      field :updated_at
    end
    edit do
      field :post
      field :url
    end
  end

end
