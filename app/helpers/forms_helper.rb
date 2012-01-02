# -*- coding: utf-8 -*-
module FormsHelper
  def self.included(base)
    ActionView::Base.default_form_builder = TwitterFormBuilder
  end

  class TwitterFormBuilder < ActionView::Helpers::FormBuilder
    delegate :content_tag, :to => :@template
    def legend(text)
      content_tag :fieldset, content_tag(:legend, text)
    end

    def text(name, options={})
      if options[:disabled]
        field = text_field(name, :disabled => true)
      else
        field = text_field(name)
      end

      field_with_label(field, name, options)
    end

    def textarea(name, options={})
      cls = options[:class] || "xxlarge"
      area = text_area(name, :class => cls)
      field_with_label(area, name, options)
    end

    def password(name, options={})
      password = password_field(name)
      field_with_label(password, name, options)
    end

    def file(name, options={})
      file = file_field(name)
      field_with_label(file, name, options)
    end

    def date(name, options={})
      options = { :default => Time.now }
      select = datetime_select(name, options, :class => "medium")
      field_with_label(select, name, options)
    end

    def dropdown(name, values, options={ })
      blank = options[:include_blank]
      size = options[:class] || "medium"
      field = select(name, values, { :include_blank => blank }, :class => size)
      field_with_label(field, name, options)
    end

    def boolean(name, options={})
      span_true = content_tag(:span, "Sí")
      span_false = content_tag(:span, "No")

      button_true = radio_button(name, true)
      button_false = radio_button(name, false)

      label_true = content_tag(:label, button_true + span_true)
      label_false = content_tag(:label, button_false + span_false)

      li_true = content_tag(:li, label_true)
      li_false = content_tag(:li, label_false)

      ul = content_tag(:ul, li_true + li_false, :class => "inputs-list")

      field_with_label(ul, name, options)
    end

    def field_with_label(content, name, options={})
      label_name = options[:label] || name

      if presence_validated?(name) || options[:required]
        label = label(label_name, nil, :class => "required")
      else
        label = label(label_name)
      end

      help = content_tag(:span, options[:help], :class => "help-block")

      content << help unless options[:help].nil?
      input = content_tag(:div, content, :class => "input")

      content << help unless help.empty?
      content_tag(:div, label + input, :class => "clearfix")
    end

    def presence_validated?(field)
      @object.class.validators_on(field).any? do |validator|
        validator.kind_of?(ActiveModel::Validations::PresenceValidator)
      end
    end
  end
end
