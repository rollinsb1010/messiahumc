# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Pastors" do
    describe "Admin" do
      describe "pastors" do
        login_refinery_user

        describe "pastors list" do
          before(:each) do
            FactoryGirl.create(:pastor, name: "UniqueTitleOne")
            FactoryGirl.create(:pastor, name: "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.pastors_admin_pastors_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.pastors_admin_pastors_path

            click_link "Add New Pastor"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", with: "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Pastors::Pastor.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::Pastors::Pastor.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:pastor, name: "UniqueTitle") }

            it "should fail" do
              visit refinery.pastors_admin_pastors_path

              click_link "Add New Pastor"

              fill_in "Name", with: "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Pastors::Pastor.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:pastor, name: "A name") }

          it "should succeed" do
            visit refinery.pastors_admin_pastors_path

            within ".actions" do
              click_link "Edit this pastor"
            end

            fill_in "Name", with: "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:pastor, name: "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.pastors_admin_pastors_path

            click_link "Remove this pastor forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Pastors::Pastor.count.should == 0
          end
        end

      end
    end
  end
end
