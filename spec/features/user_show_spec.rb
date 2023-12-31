require 'rails_helper'
RSpec.describe 'Showing a user details', type: :feature do
  before(:each) do
    @first_user = User.create(name: 'Rafi',
                              photo: 'https://c.files.bbci.co.uk/C870/production/_112921315_gettyimages-876284806.jpg', bio: 'Teacher from Mexico.')
    @second_user = User.create(name: 'Lilly Fillia',
                               photo: 'https://burst.shopifycdn.com/photos/woman-dressed-in-white-leans-against-a-wall.jpg', bio: 'I am a slutty model from Bahamas.')
    @third_user = User.create(name: 'Merkel Damian',
                              photo: 'https://images.squarespace-cdn.com/content/v1/58d1b3ff1b631bb1893d108d/813f4928-6cc6-4bc8-a4e4-265f94b4d665/matthew-hamilton-tNCH0sKSZbA-unsplash.jpg', bio: 'I am a tech professional from New york.')
    @fourth_user = User.create(name: 'Jemimah Bolaji',
                               photo: 'https://burst.shopifycdn.com/photos/modern-woman-posing-in-city.jpg', bio: 'I am a hollywood actress from San Francisco.')
    @first_post = Post.create(author: @first_user, title: 'Hi Kadarshians', text: 'This is my first post')
    @second_post = Post.create(author: @first_user, title: 'Hi Ashimolowos...', text: 'This is my second post')
    @third_post = Post.create(author: @first_user, title: 'Hi Benjamins...', text: 'This is my third post')
  end
  scenario 'I can see the user profile picture.' do
    visit users_path
    expect(page).to have_content(@first_user.name)
    click_on @first_user.name
    visit user_path(@first_user.id)
    expect(@first_user.photo).to match(%r{^https?://.*\.(jpe?g|gif|png)$})
  end

  scenario 'I can see the user username.' do
    visit users_path
    expect(page).to have_content(@first_user.name)
    click_on @first_user.name
    visit user_path(@first_user.id)
    expect(page).to have_content(@first_user.name)
  end

  scenario 'I can see the number of posts the user has written.' do
    visit users_path
    expect(page).to have_content(@first_user.name)
    click_on @first_user.name
    visit user_path(@first_user.id)
    expect(@first_user.posts_counter).to eq(3)
  end

  scenario 'I can see the user bio.' do
    visit users_path
    expect(page).to have_content(@first_user.name)
    click_on @first_user.name
    visit user_path(@first_user.id)
    expect(page).to have_content(@first_user.bio)
  end

  scenario ' I can see the user first 3 posts.' do
    visit users_path
    expect(page).to have_content(@first_user.name)
    click_on @first_user.name
    visit user_path(@first_user.id)
    expect(@first_user.latest_three_posts).to eq([@third_post, @second_post, @first_post])
  end

  scenario 'I can see a button that lets me view all of a user posts.' do
    visit users_path
    expect(page).to have_content(@first_user.name)
    click_on @first_user.name
    visit user_path(@first_user.id)
    expect(page).to have_content('See all posts')
  end

  scenario 'When I click a user post, it redirects me to that post show page.' do
    visit users_path
    expect(page).to have_content(@first_user.name)
    click_on @first_user.name
    visit user_path(@first_user.id)
    expect(page).to have_content(@first_user.name)
    visit user_post_path(@first_user.id, @first_post.id)
  end

  scenario 'When I click to see all posts, it redirects me to the user post index page.' do
    visit users_path
    expect(page).to have_content(@first_user.name)
    click_on @first_user.name
    visit user_path(@first_user.id)
    expect(page).to have_content(@first_user.name)
    visit user_posts_path(@first_user)
    expect(page).to have_content(@first_user.name)
  end
end
