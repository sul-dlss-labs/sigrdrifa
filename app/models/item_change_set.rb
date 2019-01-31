class ItemChangeSet < Valkyrie::ChangeSet
  self.fields = [:label]
  validates :label, presence: true
end
