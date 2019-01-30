# frozen_string_literal: true
# Generated with `rails generate valkyrie:model Item`
class Item < Valkyrie::Resource
  include Valkyrie::Resource::AccessControls
  attribute :title, Valkyrie::Types::Set
end
