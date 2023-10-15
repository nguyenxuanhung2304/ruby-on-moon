require_relative '../router'

Router.draw do
  get('/') do |env|
    'Namisan Blog'
  end

  get('/articles') do |env|
    'articles'
  end

  get('/articles/1') do |env|
    'Article 1'
  end
end
