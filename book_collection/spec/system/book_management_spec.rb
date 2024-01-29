require 'rails_helper'

RSpec.describe 'Book management', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'allows a user to create a new book with valid title' do
    visit new_book_path
    fill_in 'Title', with: 'New Book Title'
    fill_in 'Author', with: 'Author Name'
    fill_in 'Price', with: '19.99'
    fill_in 'book_date_posted', with: '2023-01-01' 
    click_on 'Create Book'
    expect(page).to have_content('Book was successfully created.')
  end

  it 'does not allow a user to create a book with invalid title' do
    visit new_book_path
    fill_in 'Title', with: ''
    click_on 'Create Book'
    expect(page).to have_content("Title can't be blank")
  end

  it 'is not valid without an author' do
    visit new_book_path
    fill_in 'Title', with: 'New Book Title'
    fill_in 'Author', with: ''
    fill_in 'Price', with: '20.0'
    fill_in 'book_date_posted', with: '2023-01-01'
    click_on 'Create Book'
    expect(page).to have_content("Author can't be blank")
  end


  it 'is not valid without a price' do
    visit new_book_path
    fill_in 'Title', with: 'New Book Title'
    fill_in 'Author', with: 'Author Name'
    fill_in 'Price', with: ''
    fill_in 'book_date_posted', with: '2023-01-01'
    click_on 'Create Book'
    expect(page).to have_content("Price can't be blank")
  end

  it 'is not valid without a published date' do
    visit new_book_path
    fill_in 'Title', with: 'New Book Title'
    fill_in 'Author', with: 'Author Name'
    fill_in 'Price', with: '20'
    fill_in 'book_date_posted', with: '' 
    click_on 'Create Book'
    expect(page).to have_content("Date posted can't be blank")
  end

  it 'updates a book\'s price' do
    book = Book.create(title: 'Sample Book', author: 'Sample Author', price: 20, date_posted: Date.today)
    visit edit_book_path(book)
    fill_in 'Price', with: '22'
    click_on 'Update Book'
  
    expect(page).to have_content('22')
    expect(page).to have_content('Book was successfully updated.') 
  end

  it 'shows a book information' do
    book = Book.create(title: 'Sample Book', author: 'Sample Author', price: 0, date_posted: Date.today)
    visit book_path(book)
    expect(page).to have_content('Sample Book')
    expect(page).to have_content('Sample Author')
    expect(page).to have_content('0')
    expect(page).to have_content(book.date_posted.to_s)
  end


  it 'deletes a book' do
    book = Book.create(title: 'Sample Book', author: 'Sample Author', price: 20, date_posted: Date.today)
    visit delete_book_path(book)
    click_on 'Yes'
    expect(page).to have_content('Book was successfully destroyed.') 
    expect(page).not_to have_content('Sample Book') 
  end
end
