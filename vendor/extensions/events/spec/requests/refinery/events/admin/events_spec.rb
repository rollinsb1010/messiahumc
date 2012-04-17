# encoding: utf-8
require 'spec_helper'

describe Refinery do
  describe 'Events' do
    describe 'Admin' do
      describe 'events' do
        login_refinery_user

        describe 'events list' do
          before(:each) do
            FactoryGirl.create(:event, title: 'UniqueTitleOne')
            FactoryGirl.create(:event, title: 'UniqueTitleTwo')
          end

          it 'shows two items' do
            visit refinery.events_admin_events_path
            page.should have_content('UniqueTitleOne')
            page.should have_content('UniqueTitleTwo')
          end
        end

        describe 'create' do
          before(:each) do
            visit refinery.events_admin_events_path

            click_link 'Add New Event'
          end

          context 'valid data' do
            it 'should succeed' do
              fill_in 'Title', with: 'The event title'
              select '2013', from: 'event_date_1i'
              select 'January', from: 'event_date_2i'
              select '1', from: 'event_date_3i'
              fill_in 'Short Description', with: 'A short description'
              fill_in 'event[long_description]', with: 'A long description'
              fill_in 'Contact Email', with: 'a_valid@email.com'
              click_button 'Save'

              page.should have_content('\'The event title\' was successfully added.')
              Refinery::Events::Event.count.should == 1
            end
          end

          context 'invalid data' do
            it 'should fail' do
              click_button 'Save'

              page.should have_content('Title can\'t be blank')
              Refinery::Events::Event.count.should == 0
            end
          end

          context 'duplicate' do
            before(:each) { FactoryGirl.create(:event, title: 'UniqueTitle') }

            it 'should fail' do
              visit refinery.events_admin_events_path

              click_link 'Add New Event'

              fill_in 'Title', with: 'UniqueTitle'
              click_button 'Save'

              page.should have_content('There were problems')
              Refinery::Events::Event.count.should == 1
            end
          end

        end

        describe 'edit' do
          before(:each) { FactoryGirl.create(:event, title: 'A title') }

          it 'should succeed' do
            visit refinery.events_admin_events_path

            within '.actions' do
              click_link 'Edit this event'
            end

            fill_in 'Title', with: 'A different title'
            click_button 'Save'

            page.should have_content('\'A different title\' was successfully updated.')
            page.should have_no_content('A title')
          end
        end

        describe 'destroy' do
          before(:each) { FactoryGirl.create(:event, title: 'UniqueTitleOne') }

          it 'should succeed' do
            visit refinery.events_admin_events_path

            click_link 'Remove this event forever'

            page.should have_content('\'UniqueTitleOne\' was successfully removed.')
            Refinery::Events::Event.count.should == 0
          end
        end

      end
    end
  end
end
