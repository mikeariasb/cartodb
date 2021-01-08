shared_context 'users helper' do
  include_context 'database configuration'
  include CartoDB::Factories

  before(:all) do
    @user1 = FactoryGirl.create(:valid_user, private_tables_enabled: true, private_maps_enabled: true)
    @carto_user1 = Carto::User.find(@user1.id)
    @user2 = FactoryGirl.create(:valid_user, private_tables_enabled: true, private_maps_enabled: true)
    @carto_user2 = Carto::User.find(@user2.id)
  end

  before do
    allow_any_instance_of(CartoDB::UserModule::DBService).to receive(:enable_remote_db_user).and_return(true)
    bypass_named_maps
    delete_user_data @user1
    delete_user_data @user2
  end

  after(:all) do
    @user1.destroy if @user1
    @user2.destroy if @user2
  end

  after { bypass_named_maps }
end

shared_context 'user helper' do
  include CartoDB::Factories

  before(:all) do
    @user = FactoryGirl.create(:valid_user)
    @carto_user = Carto::User.find(@user.id)
  end

  before do
    bypass_named_maps
    delete_user_data(@user)
  end

  after(:all) do
    @user.destroy
  end

  after { bypass_named_maps }
end
