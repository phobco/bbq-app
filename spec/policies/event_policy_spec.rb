require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:user) { User.new }
  let(:event_creator) { User.new }
  let(:event) { event_creator.events.build }

  subject { EventPolicy }

  context 'when user is a creator of event' do
    permissions :show?, :edit?, :update?, :destroy? do
      it 'gives access to event creator' do
        expect(subject).to permit(event_creator, event)
      end
    end
  end

  context 'when user is authorized but not the event creator' do
    permissions :show? do
      it 'gives access to the user' do
        expect(subject).to permit(user, event)
      end
    end

    permissions :edit?, :update?, :destroy? do
      it 'does not give access to the user' do
        expect(subject).not_to permit(user, event)
      end
    end
  end

  context 'when the user is anonymous' do
    permissions :show? do
      it 'gives access to the user' do
        expect(subject).to permit(true, event)
      end
    end

    permissions :edit?, :update?, :destroy? do
      it 'does not give access to the user' do
        expect(subject).not_to permit(false, event)
      end
    end
  end
end
