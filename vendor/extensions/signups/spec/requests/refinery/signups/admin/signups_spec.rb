# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Signups" do
    describe "Admin" do
      describe "signups" do
        login_refinery_user

        describe "signups list" do
          before do
            FactoryGirl.create(:signup, :name => "UniqueTitleOne")
            FactoryGirl.create(:signup, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.signups_admin_signups_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.signups_admin_signups_path

            click_link "Add New Signup"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Signups::Signup.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::Signups::Signup.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:signup, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.signups_admin_signups_path

              click_link "Add New Signup"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Signups::Signup.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:signup, :name => "A name") }

          it "should succeed" do
            visit refinery.signups_admin_signups_path

            within ".actions" do
              click_link "Edit this signup"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:signup, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.signups_admin_signups_path

            click_link "Remove this signup forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Signups::Signup.count.should == 0
          end
        end

      end
    end
  end
end
