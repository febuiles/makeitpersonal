# -*- coding: utf-8 -*-
require 'fast_spec_helper'
require 'lyrics/text_processor'
require 'lyrics/fetcher'
require 'nokogiri'
include Lyrics

describe TextProcessor do
  let(:document) { File.dirname(__FILE__) + "/../../fixtures/lyrics.html" }
  let(:text) { File.read(document) }
  let(:processor) { TextProcessor.new(text) }

  describe "#clean_result" do
    it "parses the document and returns the lyrics" do
      processor.clean_result.lyrics.should == "\nZOMGLYRICS\n"
    end
  end

  context "duplicate lyrics" do
    it "doesn't return duplicate lyrics" do
      fake_document = File.dirname(__FILE__) + "/../../fixtures/song_with_duplicates.html"
      processor = TextProcessor.new(File.read(fake_document, :encoding => "UTF-8"))
      processor.clean_result.lyrics.should == "\nThis is so fun\n"
    end
  end

  context "redirects" do
    describe "#clean_result" do
      let(:fetcher) { stub }
      before do
        fetcher.should_receive(:text)
        TextFetcher.should_receive(:new).and_return(fetcher)
      end

      it "follows redirects" do
        fake_document = File.dirname(__FILE__) + "/../../fixtures/song_with_redirect.html"
        processor = TextProcessor.new(File.read(fake_document))
        processor.clean_result
        expect { processor.clean_result }.not_to raise_error
      end
    end
  end
end
