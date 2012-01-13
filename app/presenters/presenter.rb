require "action_controller"
require "application_controller"

class Presenter
  attr_reader :record, :helper

  def initialize(record)
    @record = record
    @helper = ApplicationController.helpers
  end

  # We first try to delegate all the Rails helper methods, if `helper`
  # doesn't respond to a method we try with `record`. If not we fail.
  def method_missing(name, *arguments, &block)
    if helper.respond_to?(name)
      helper.send(name, *arguments, &block)
    elsif record.respond_to?(name)
      record.send(name, *arguments, &block)
    else
      super
    end
  end
end
