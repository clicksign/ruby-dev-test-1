require 'rails_helper'

RSpec.describe Album, type: :model do



  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to belong_to :player }
  it { is_expected.to have_and_belong_to_many (:players) }

  it { is_expected.to validate_presence_of(:image) }

  it 'valid album' do
    player = create(:player)
    album = create(:album, player: player)
    expect(album).to be_valid
  end

  it 'presence of name' do
    album = Album.new
    expect(album).not_to be_valid
  end

  it 'presence of players is valid if image is attached' do

    file = Rails.root.join('spec', 'support', 'assets','madona.png')
    image = ActiveStorage::Blob.create_after_upload!(
      io: File.open(file, 'rb'),
      filename: 'madona.png',
      content_type: 'image/png'
    ).signed_id

    shakira = Player.create(name: 'Shakira')
    madona = Player.create(name: 'Madona')
    madona_album = shakira.albums.create(name:' Album Madona', player: madona, image: image)
    expect(madona_album).to be_valid
  end
end