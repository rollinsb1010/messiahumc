# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "StaffMembers" do
    describe "Admin" do
      describe "staff_members" do
        login_refinery_user

        describe "staff_members list" do
          before(:each) do
            FactoryGirl.create(:staff_member, name: "UniqueTitleOne")
            FactoryGirl.create(:staff_member, name: "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.staff_members_admin_staff_members_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            FactoryGirl.create(:category, name: 'The category')
            visit refinery.staff_members_admin_staff_members_path

            click_link "Add New Staff Member"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", with: "This is a test of the first string field"
              select 'The category', from: 'Category'
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::StaffMembers::StaffMember.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::StaffMembers::StaffMember.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:staff_member, name: "UniqueTitle") }

            it "should fail" do
              visit refinery.staff_members_admin_staff_members_path

              click_link "Add New Staff Member"

              fill_in "Name", with: "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::StaffMembers::StaffMember.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:staff_member, name: "A name") }

          it "should succeed" do
            visit refinery.staff_members_admin_staff_members_path

            within ".actions" do
              click_link "Edit this staff member"
            end

            fill_in "Name", with: "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:staff_member, name: "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.staff_members_admin_staff_members_path

            click_link "Remove this staff member forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::StaffMembers::StaffMember.count.should == 0
          end
        end

      end
    end
  end
end
