require "rails_helper"

RSpec.describe User, type: :model do
  context "validation tests" do
    it "ensures email presence" do
      user = User.new(name:"Rogerio", password:"123asd!@#WER").save
      expect(user).to eq(false)
    end
    it "ensures name presence" do
      user = User.new(email: "rogerio@ltr.com", password:"123asd!@#WER").save
      expect(user).to eq(false)
    end
    it "ensures password presence" do
      user = User.new(name:"Rogerio", email: "rogerio@ltr.com").save
      expect(user).to eq(false)
    end
    it "checks default user to be :user" do
      user = User.new(name:"Rogerio", email: "rogerio@ltr.com")
      user.save
      expect(user.role).to eq("user")
      expect(user.admin?).to eq(false)
    end
    it "checks creation of admin user" do
      user = User.new(name:"Rogerio", email: "rogerio@ltr.com", role: "admin")
      user.save
      expect(user.role).to eq("admin")
      expect(user.user?).to eq(false)
    end
    it "should save successfully" do
      user = User.new(name:"Rogerio", password:"123asd!@#WER", email: "rogerio@ltr.com").save
      expect(user).to eq(true)
    end

  end
end
