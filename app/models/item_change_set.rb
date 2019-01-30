class ItemChangeSet < Valkyrie::ChangeSet
  self.fields = [:title]
  validates :title, presence: true
end
