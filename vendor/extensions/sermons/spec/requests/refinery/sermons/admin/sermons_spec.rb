# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Sermons" do
    describe "Admin" do
      describe "sermons" do
        login_refinery_user

        describe "sermons list" do
          before(:each) do
            FactoryGirl.create(:sermon, title: "UniqueTitleOne")
            FactoryGirl.create(:sermon, title: "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.sermons_admin_sermons_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            FactoryGirl.create :pastor, name: 'The pastor'
            visit refinery.sermons_admin_sermons_path

            click_link "Add New Sermon"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Title", with: "This is a test of the first string field"
              select 'The pastor', from: 'Pastor'
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Sermons::Sermon.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Title can't be blank")
              Refinery::Sermons::Sermon.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:sermon, title: "UniqueTitle") }

            it "should fail" do
              visit refinery.sermons_admin_sermons_path

              click_link "Add New Sermon"

              fill_in "Title", with: "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Sermons::Sermon.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:sermon, title: "A title") }

          it "should succeed" do
            visit refinery.sermons_admin_sermons_path

            within ".actions" do
              click_link "Edit this sermon"
            end

            fill_in "Title", with: "A different title"
            click_button "Save"

            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:sermon, title: "UniqueTitleOne") }

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
