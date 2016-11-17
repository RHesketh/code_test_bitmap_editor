require 'spec_helper'
require './app/input_handler'

describe 'InputHandler' do
  let (:handler) { InputHandler.new }
  context "When input is not recognised" do
    it "outputs a warning" do
      expect { handler.parse("F") }.to output(/unrecognised command :\(/).to_stdout
    end
  end
end