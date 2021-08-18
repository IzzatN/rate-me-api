class CommentSerializer
    include FastJsonapi::ObjectSerializer

    set_type :comment

    attributes  :text,
                :created_at

    belongs_to :user
    belongs_to :service
end
  