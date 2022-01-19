require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:event) { FactoryBot.create(:event, user: event_creator) }
  let(:secure_event) { FactoryBot.create(:event, user: event_creator  , pincode: '0000') }
  
  let(:user) { FactoryBot.create(:user) }
  let(:event_creator) { FactoryBot.create(:user) }

  let(:event_creator_context) { UserContext.new(event_creator, {}) }
  let(:user_without_access_context) { UserContext.new(user, {}) }
  let(:unregistered_user_with_access_context) { UserContext.new(nil, cookies) }

  let(:cookies) { { "events_#{secure_event.id}_pincode" => '0000' } }

  subject { EventPolicy }

  context 'when user tries to view the event' do
    context 'and pincode is present' do
      context 'and the user is event creator' do
        permissions :show? do
          it 'give access to event' do
            expect(subject).to permit(event_creator_context, secure_event)
          end
        end
      end

      context 'and unregistered user has valid cookies' do
        permissions :show? do
          it 'give access to event' do
            expect(subject).to permit(unregistered_user_with_access_context, secure_event)
          end
        end
      end

      context 'when user has no cookies' do
        permissions :show? do
          it 'does not give access to event' do
            expect(subject).not_to permit(user_without_access_context, secure_event)
          end
        end
      end
    end
  end

  context 'when user tries to edit, update, delete event' do
    context 'when the user is event creator'do
      permissions :edit?, :update?, :destroy? do
        it 'give access to event creator' do
          expect(subject).to permit(event_creator_context, event)
        end
      end
    end

    context 'when user in not event creator' do
      permissions :edit?, :update?, :destroy? do
        it 'not give access to user' do
          expect(subject).not_to permit(user_without_access_context, event)
        end
      end
    end

    context 'when user is unregistered' do
      permissions :edit?, :update?, :destroy? do
        it 'not give access to user' do
          expect(subject).not_to permit(unregistered_user_with_access_context, event)
        end
      end
    end
  end
end
