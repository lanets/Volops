require 'rails_helper'

RSpec.describe PagesController, type: :controller do
    context 'GET #index' do
        it 'returns a success response' do
            get :index
            expect(response).to be_success # response.success?
        end
    end

end
