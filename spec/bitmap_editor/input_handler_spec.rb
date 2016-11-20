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

      it "creates a new canvas upon instantiation if nil" do
        expect(Canvas).to receive(:new).and_call_original

        handler.parse("I 5 5")
      end
    end
  end

  context "When the command is not recognised" do
    it "displays a meaningful error message to the user" do
      expect { handler.parse("F") }.to output(/unrecognised command :\(/).to_stderr
    end
  end

    context "When the command does not have enough arguments" do
    it "displays a meaningful error message to the user" do
      expect { handler.parse("I") }.to output(/ERROR:/).to_stderr
      expect { handler.parse("I 5") }.to output(/ERROR:/).to_stderr
    end
  end


  context "When the command has too many arguments" do
    it "displays a meaningful error message to the user" do
      expect { handler.parse("I 5 5 5") }.to output(/ERROR:/).to_stderr
    end
  end

  context "When a command causes an error to be raised" do
    it "the error is handled" do
      expect{handler.parse("I 251 251")}.not_to raise_error
    end

    it "a meaningful message is shown to the user" do
      expect { handler.parse("I 251 251") }.to output(/Invalid argument\(s\)/).to_stderr
    end
  end

  # New Image command (I)
  
  context "When the 'new image' command is given" do
    let(:fake_canvas) { spy("Canvas") }
    let(:handler) { InputHandler.new(fake_canvas)}

    it "does not output anything" do
       expect { handler.parse("I 5 5") }.to_not output.to_stdout
    end

    it "tells the canvas to create a new image using the specified dimensions" do
      width = 5
      height = 6

      expect(fake_canvas).to receive(:new_image).with(width,height)

      handler.parse("I #{width} #{height}")
    end
  end
end