require 'rails_helper'


RSpec.describe EventsController, type: :controller do
=begin
    context 'GET #edit' do
        it 'returns a success response' do
            event = Event.create!(title: 'Title', start_date: DateTime.now, end_date: DateTime.now + 10.days )
            get :edit, params: {id: event.id}
            expect(response).to be_success
        end
    end
=end
end
