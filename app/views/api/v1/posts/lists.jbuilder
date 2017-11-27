json.posts do
  json.array! @posts, partial: 'v1/posts/_post', as: :post
end
json.partial! 'v1/_pagination', pagination: @pagination
