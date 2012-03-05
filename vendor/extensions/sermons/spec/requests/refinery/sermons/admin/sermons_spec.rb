# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Sermons" do
    describe "Admin" do
      describe "sermons" do
        login_refinery_user

        describe "sermons list" do
          before(:each) do
            FactoryGirl.create(:sermon, :speaker => "UniqueTitleOne")
            FactoryGirl.create(:sermon, :speaker => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.sermons_admin_sermons_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.sermons_admin_sermons_path

            click_link "Add New Sermon"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Speaker", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Sermons::Sermon.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Speaker can't be blank")
              Refinery::Sermons::Sermon.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:sermon, :speaker => "UniqueTitle") }

            it "should fail" do
              visit refinery.sermons_admin_sermons_path

              click_link "Add New Sermon"

              fill_in "Speaker", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Sermons::Sermon.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:sermon, :speaker => "A speaker") }

          it "should succeed" do
            visit refinery.sermons_admin_sermons_path

            within ".actions" do
              click_link "Edit this sermon"
            end

            fill_in "Speaker", :with => "A different speaker"
            click_button "Save"

            page.should have_content("'A different speaker' was successfully updated.")
            page.should have_no_content("A speaker")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:sermon, :speaker => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.sermons_admin_sermons_path

            click_link "Remove this sermon forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Sermons::Sermon.count.should == 0
          end
        end

      end
    end
  end
end
