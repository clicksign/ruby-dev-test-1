RSpec.shared_examples 'when not has value in attribute' do |name_attribute|
  before do
    subject.send("#{name_attribute}=", nil)
  end

  it { is_expected.to be_invalid }

  it 'with key error' do
    subject.valid?

    expect(subject.errors).to have_key(name_attribute)
  end
end
