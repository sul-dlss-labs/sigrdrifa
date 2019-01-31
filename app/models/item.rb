# frozen_string_literal: true
# Generated with `rails generate valkyrie:model Item`
class Item < Valkyrie::Resource
  include Valkyrie::Resource::AccessControls
  attribute :label, Valkyrie::Types::String
end
