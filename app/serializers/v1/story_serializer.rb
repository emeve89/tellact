class V1::StorySerializer < ActiveModel::Serializer
  attributes :title, :body, :created_at, :abstract, :id
  has_one :user, serializer: UserSerializer

  def abstract
    object.body[0..100]
  end
end
