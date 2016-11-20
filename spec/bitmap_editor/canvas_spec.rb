require 'spec_helper'
require './app/canvas'

describe 'Canvas' do
  let (:subject) {Canvas.new}

  describe "#new_image" do
    it "responds to :new_image" do 
      expect(subject.respond_to?(:new_image)).to eq(true)
    end

    it "creates a blank image using the specified dimensions" do
      subject.new_image(3, 2)

      comparison = StringIO.new
      comparison << "OOO\n"
      comparison << "OOO\n"

      expect(subject.render).to eq comparison.string
    end

    it "replaces any existing image" do
      subject.new_image(5, 6)
      subject.new_image(2, 2)

      comparison = StringIO.new
      comparison << "OO\n"
      comparison << "OO\n"

      expect(subject.render).to eq comparison.string
    end

    it "raises an error if the canvas is less than 1 pixel wide or 1 pixel high" do
      expect{subject.new_image( 0,  0)}.to raise_error(ArgumentError)
      expect{subject.new_image(-1,  1)}.to raise_error(ArgumentError)
      expect{subject.new_image( 1, -1)}.to raise_error(ArgumentError)

    end
    it "raises an error if the canvas is more than 250 pixel wide or 250 pixels high" do 
      expect{subject.new_image( 251,  251)}.to raise_error(ArgumentError)
      expect{subject.new_image(251,  5)}.to raise_error(ArgumentError)
      expect{subject.new_image( 5, 251)}.to raise_error(ArgumentError)
    end

    it "raises an error if the width and height are not integers" do 
      expect{subject.new_image(1, "A")}.to raise_error(ArgumentError)
      expect{subject.new_image("A", 1)}.to raise_error(ArgumentError)
      expect{subject.new_image(6.6, 1)}.to raise_error(ArgumentError)
    end
  end

  describe "#set_pixel" do
    before(:each) do
      subject.new_image(5, 5)
    end
    it "responds to :set_pixel" do 
      expect(subject.respond_to?(:set_pixel)).to eq(true)
    end

    it "raises an error if x or y is less than 1" do
      expect{subject.set_pixel( 0,  0, "K")}.to raise_error(ArgumentError)
      expect{subject.set_pixel(-1,  1, "K")}.to raise_error(ArgumentError)
      expect{subject.set_pixel( 1, -1, "K")}.to raise_error(ArgumentError)
    end

    # The image is 1-indexed
    it "raises an error if x is greater than image width or y is greater than image height" do
      expect{subject.set_pixel(6, 5, "K")}.to raise_error(ArgumentError)
      expect{subject.set_pixel(6, 2, "K")}.to raise_error(ArgumentError)
      expect{subject.set_pixel(2, 6, "K")}.to raise_error(ArgumentError)
    end

    it "raises an error if the width and height are not integers" do 
      expect{subject.set_pixel(1, "A", "K")}.to raise_error(ArgumentError)
      expect{subject.set_pixel("A", 1, "K")}.to raise_error(ArgumentError)
      expect{subject.set_pixel(6.6, 1, "K")}.to raise_error(ArgumentError)
    end

    it "raises an error if the colour is not a capital letter" do 
      expect{subject.set_pixel(1, 1, "k")}.to raise_error(ArgumentError)
      expect{subject.set_pixel(1, 1, 1)}.to raise_error(ArgumentError)
    end

    it "quietly do nothing if called before an image has been created" do
      imageless_subject = Canvas.new
      expect{imageless_subject.set_pixel(1, 1, "A")}.not_to raise_error
    end

    it "sets the specified pixel to the specified colour" do
      subject.set_pixel(2, 4, "B")

      comparison = StringIO.new
      comparison << "OOOOO\n"
      comparison << "OOOOO\n"
      comparison << "OOOOO\n"
      comparison << "OBOOO\n"
      comparison << "OOOOO\n"

      expect(subject.render).to eq comparison.string
    end
  end

  describe "#render" do 
    it "returns a representation of the canvas as a string" do 
      subject.new_image(1,1)

      expect(subject.render).to eq "O\n"
    end

    it "returns nil if the canvas has not created an image yet" do
      expect(subject.render).to be_nil
    end
  end
end