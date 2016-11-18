require 'spec_helper'
require './app/input_handler'

describe 'InputHandler' do
  let (:handler) { InputHandler.new }

  context "Options hash" do
    it "is optional" do
      expect {InputHandler.new}.not_to raise_error
      expect {InputHandler.new(some_option: true)}.not_to raise_error
    end

    describe "options[:canvas]" do
      it "specifies the canvas to be used" do
        fake_canvas = spy("Canvas")
        input_handler = InputHandler.new(canvas: fake_canvas)

        expect(fake_canvas).to receive(:new_image)

        input_handler.parse("I 5 5")
      end

      it "creates a new canvas upon instantiation if this option is nil" do
        expect(Canvas).to receive(:new).and_call_original

        handler.parse("I 5 5")
      end
    end
  end

  context "When the command is not recognised" do
    it "outputs a warning" do
      expect { handler.parse("F") }.to output(/unrecognised command :\(/).to_stdout
    end
  end

  context "When the 'new image' command is given" do
    context "with valid image dimensions" do
      it "does not output anything" do
         expect { handler.parse("I 5 5") }.to_not output.to_stdout
      end

      it "tells the canvas to create a new image using the specified dimensions" do
        fake_canvas = spy("Canvas")
        width = 5
        height = 6
        input_handler = InputHandler.new(canvas: fake_canvas)

        expect(fake_canvas).to receive(:new_image).with(width,height)

        input_handler.parse("I #{width} #{height}")
      end
    end

    context "with invalid image dimensions" do
      xit "does not raise an error"
      xit "outputs a useful error message"
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