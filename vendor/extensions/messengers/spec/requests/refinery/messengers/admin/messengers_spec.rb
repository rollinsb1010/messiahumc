# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Messengers" do
    describe "Admin" do
      describe "messengers" do
        login_refinery_user

        describe "messengers list" do
          before(:each) do
            FactoryGirl.create(:messenger, :messenger_type => "UniqueTitleOne")
            FactoryGirl.create(:messenger, :messenger_type => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.messengers_admin_messengers_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.messengers_admin_messengers_path

            click_link "Add New Messenger"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Messenger Type", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Messengers::Messenger.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Messenger Type can't be blank")
              Refinery::Messengers::Messenger.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:messenger, :messenger_type => "UniqueTitle") }

            it "should fail" do
              visit refinery.messengers_admin_messengers_path

              click_link "Add New Messenger"

              fill_in "Messenger Type", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Messengers::Messenger.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:messenger, :messenger_type => "A messenger_type") }

          it "should succeed" do
            visit refinery.messengers_admin_messengers_path

            within ".actions" do
              click_link "Edit this messenger"
            end

            fill_in "Messenger Type", :with => "A different messenger_type"
            click_button "Save"

            page.should have_content("'A different messenger_type' was successfully updated.")
            page.should have_no_content("A messenger_type")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:messenger, :messenger_type => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.messengers_admin_messengers_path

            click_link "Remove this messenger forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Messengers::Messenger.count.should == 0
          end
        end

      end
    end
  end
end
