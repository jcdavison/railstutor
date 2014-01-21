require "spec_helper"

describe Student do
  before do
    @student = FactoryGirl.build :student
    Student.any_instance.stubs(:valid_email?).returns true
  end

  context "a normal Student" do

    it "requires first_name" do
      @student.first_name = nil
      @student.valid?.should be_false
    end

    it "requires last_name" do
      @student.last_name = nil
      @student.valid?.should be_false
    end

    it "requires email" do
      @student.email = nil
      @student.valid?.should be_false
    end

    it "requires unique email" do
      @student.save.should be_true
      @another_student = FactoryGirl.build :student
      @another_student.save.should be_false
    end

    it "validates the email address and subscribes to hackers@ list" do
      @student.expects :validate_email_and_subscribe
      @student.save
    end
  end

  context "#in_process" do
    before do
      @params = { first_name: @student.first_name,
        last_name: @student.last_name, 
        email: @student.email, applied: "false" }
    end

    it "returns created on new student save" do
      Student.in_process(@params).should == "created"
    end

    it "returns rejected if Student alreadys exists" do
      @student.save.should be_true
      Student.in_process(@params).should == "rejected"
    end

    it "returns applied if Student exists and is applying" do
      @params[:applied] = "true"
      Student.in_process(@params).should == "applied"
    end
  end

  context "#full_name" do
    it "handles nil cases" do
      @student.first_name = nil
      @student.full_name.should be_nil
      @student.first_name = "john"
      @student.last_name = nil
      @student.full_name.should be_nil
    end
  end

  context "#populate_list" do
    it "adds each Student to the mailing list" do
      @student.save
      Student.any_instance.expects(:add_to_mailing_list).once
      Student.populate_list
    end
  end

  context "#remove_invalid" do
    it "removes Students lacking email" do
      @student.save
      Student.any_instance.stubs(:valid_email?).returns false
      Student.any_instance.expects(:destroy).once
      Student.remove_invalid!
    end
  end

end
