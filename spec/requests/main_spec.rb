require "spec_helper"

describe MainController do
  context "POST /join.json" do
    context "no params" do
      it "returns 400" do
        post 'join.json'
        expect(response.status).to be(400)
      end
    end

    context "invalid email" do
      it "returns 400" do
        post 'join.json', email: "jcd"
        expect(response.status).to be(400)
      end
    end

    context "correctly formed params" do
      before do
        Student.any_instance.stubs(:valid_email?).returns true
        Student.any_instance.expects(:add_to_mailing_list).once
      end

      it "returns 200" do
        new_student = {first_name: "j", last_name: "d", email: "person@test.com", applied: "false" }
        post 'join.json', new_student 
        expect(response.status).to eq(200)
      end
    end
  end


end
