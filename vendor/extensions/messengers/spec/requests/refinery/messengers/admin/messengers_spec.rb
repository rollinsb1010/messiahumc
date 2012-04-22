# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Messengers" do
    describe "Admin" do
      describe "messengers" do
        login_refinery_user

        describe "messengers list" do
          before(:each) do
            FactoryGirl.create(:messenger, messenger_type: 'weekly')
            FactoryGirl.create(:messenger, messenger_type: 'monthly')
          end

          it "shows two items" do
            visit refinery.messengers_admin_messengers_path
            page.should have_content("Weekly Messenger")
            page.should have_content("Monthly Messenger")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.messengers_admin_messengers_path

            click_link "Add New Messenger"
          end

          context "valid data" do
            it "should succeed" do
              select 'weekly', from: "Messenger Type"
              click_button "Save"

              page.should have_content("Weekly Messenger")
              Refinery::Messengers::Messenger.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              select 'Please select', from: 'Messenger Type'
              click_button "Save"

              page.should have_content("Messenger Type can't be blank")
              Refinery::Messengers::Messenger.count.should == 0
            end
          end
        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:messenger, messenger_type: "weekly") }

          it "should succeed" do
            visit refinery.messengers_admin_messengers_path

            within ".actions" do
              click_link "Edit this messenger"
            end

            select 'monthly', from: "Messenger Type"
            click_button "Save"

            page.should have_content("Monthly Messenger")
            page.should have_no_content("Weekly Messenger")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:messenger, messenger_type: 'weekly') }

          it "should succeed" do
            visit refinery.messengers_admin_messengers_path

            click_link "Remove this messenger forever"

            page.should have_content("'weekly' was successfully removed.")
            Refinery::Messengers::Messenger.count.should == 0
          end
        end

      end
    end
  end
end
