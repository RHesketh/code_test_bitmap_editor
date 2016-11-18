require 'spec_helper'
require './app/input_handler'

describe 'InputHandler' do
  let (:handler) { InputHandler.new }
  context "When input is not recognised" do
    it "outputs a warning" do
      expect { handler.parse("F") }.to output(/unrecognised command :\(/).to_stdout
    end
  end

  context "When the 'new image' command is given" do
    context "With valid image dimensions" do
      it "does not output anything" do
         expect { handler.parse("I 5 5") }.to_not output.to_stdout
      end
    end

    context "With not enough arguments" do
      it "outputs an error" do
        expect { handler.parse("I") }.to output(/invalid argument\(s\)/).to_stdout
        expect { handler.parse("I 5") }.to output(/invalid argument\(s\)/).to_stdout
      end
    end

    context "With too many arguments" do
      it "outputs an error" do
        expect { handler.parse("I 5 5 5") }.to output(/invalid argument\(s\)/).to_stdout
      end
    end

    context "With arguments that are not integers" do
      it "outputs an error" do
        expect { handler.parse("I 5 Y") }.to output(/invalid argument\(s\)/).to_stdout
        expect { handler.parse("I X 5") }.to output(/invalid argument\(s\)/).to_stdout
        expect { handler.parse("I X Y") }.to output(/invalid argument\(s\)/).to_stdout
      end
    end
  end
end