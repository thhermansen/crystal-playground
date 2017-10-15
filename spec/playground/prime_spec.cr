require "../spec_helper"
require "../../src/playground/prime"

module Playground
  describe Prime do
    describe "::prime?" do
      it "calcualtes 2 as prime" do
        Prime.prime?(2).should be_true
      end

      it "calcualtes 3 as prime" do
        Prime.prime?(3).should be_true
      end

      it "calcualtes 4 as not prime" do
        Prime.prime?(4).should be_false
      end
    end

    it "returns prime numbers" do
      Prime.new.first(1).to_a.should eq [2]
      Prime.new.first(10).to_a.should eq [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
    end
  end
end
