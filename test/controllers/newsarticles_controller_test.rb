# frozen_string_literal: true

require 'test_helper'

class NewsarticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @newsarticle = newsarticles(:one)
  end

  test 'should get index' do
    get newsarticles_url
    assert_response :success
  end

  test 'should get new' do
    get new_newsarticle_url
    assert_response :success
  end

  test 'should create newsarticle' do
    assert_difference('Newsarticle.count') do
      post newsarticles_url,
           params: { newsarticle: { articlelink: @newsarticle.articlelink, author: @newsarticle.author,
                                    imglink: @newsarticle.imglink, source: @newsarticle.source, text: @newsarticle.text, title: @newsarticle.title } }
    end

    assert_redirected_to newsarticle_url(Newsarticle.last)
  end

  test 'should show newsarticle' do
    get newsarticle_url(@newsarticle)
    assert_response :success
  end

  test 'should get edit' do
    get edit_newsarticle_url(@newsarticle)
    assert_response :success
  end

  test 'should update newsarticle' do
    patch newsarticle_url(@newsarticle),
          params: { newsarticle: { articlelink: @newsarticle.articlelink, author: @newsarticle.author,
                                   imglink: @newsarticle.imglink, source: @newsarticle.source, text: @newsarticle.text, title: @newsarticle.title } }
    assert_redirected_to newsarticle_url(@newsarticle)
  end

  test 'should destroy newsarticle' do
    assert_difference('Newsarticle.count', -1) do
      delete newsarticle_url(@newsarticle)
    end

    assert_redirected_to newsarticles_url
  end
end
