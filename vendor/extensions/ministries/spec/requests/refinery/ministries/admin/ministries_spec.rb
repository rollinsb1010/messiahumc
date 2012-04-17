# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Ministries" do
    describe "Admin" do
      describe "ministries" do
        login_refinery_user

        describe "ministries list" do
          before(:each) do
            FactoryGirl.create(:ministry, name: "UniqueTitleOne")
            FactoryGirl.create(:ministry, name: "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.ministries_admin_ministries_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.ministries_admin_ministries_path
            FactoryGirl.create(:ministry_category, name: 'The category')

            click_link "Add New Ministry"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", with: "This is a test of the first string field"
              select 'The category', from: 'Ministry Category'
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Ministries::Ministry.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::Ministries::Ministry.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:ministry, name: "UniqueTitle") }

            it "should fail" do
              visit refinery.ministries_admin_ministries_path

              click_link "Add New Ministry"

              fill_in "Name", with: "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Ministries::Ministry.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:ministry, name: "A name") }

          it "should succeed" do
            visit refinery.ministries_admin_ministries_path

            within ".actions" do
              click_link "Edit this ministry"
            end

            fill_in "Name", with: "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:ministry, name: "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.ministries_admin_ministries_path

            click_link "Remove this ministry forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Ministries::Ministry.count.should == 0
          end
        end

      end
    end
  end
end
