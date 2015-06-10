require 'spec_helper'

describe AppleSearcher::Devise do
  describe "find method" do
    it "return status Is Warranty" do
      imei = "013977000323877"
      # return Parser object
      res = AppleSearcher::Devise.find(imei)
      expect(res.warranty).to eq true
      expect(res.expired_date).to eq "August 10, 2016"
    end

    it "return status out of warranty" do
      imei = "013896000639712"
      res = AppleSearcher::Devise.find(imei)
      expect(res.warranty).to eq false
      expect(res.expired_date).to be_nil
    end

    it "false if invalid imei" do
      imei = "fuck12302"
      parser = AppleSearcher::Devise.find(imei)
      expect(parser).to be_nil
    end

    it "error if empty imei" do
      imei = ""
      parser = AppleSearcher::Devise.find(imei)
      expect(parser).to be_nil
    end

    it "error if imei is very big" do
      imei = "1u693576983475986734895769837456987346783946893456"
      parser = AppleSearcher::Devise.find(imei)
      expect(parser).to be_nil
    end

    it "error if imei has wrong sybols" do
      imei = "&@*&(*$&(@*&#(*"
      parser = AppleSearcher::Devise.find(imei)
      expect(parser).to be_nil
    end
  end

  describe "find! method" do
    it "raise exception if invalid imei" do
      imei = "fuck12302"
      expect { AppleSearcher::Devise.find!(imei) } 
        .to raise_error
    end

    it "success if valid imei" do
      imei = "013977000323877"
      res = AppleSearcher::Devise.find!(imei)
      expect(res.warranty).to eq true
      expect(res.expired_date).to eq "August 10, 2016"
    end
  end
end
