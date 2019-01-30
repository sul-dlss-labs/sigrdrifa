class ChangeSetPersister
  attr_reader :metadata_adapter, :storage_adapter

  delegate :persister, to: :metadata_adapter

  def initialize(metadata_adapter: default_metadata_adapter, storage_adapter: default_storage_adapter)
    @metadata_adapter = metadata_adapter
    @storage_adapter = storage_adapter
  end

  def save(change_set:)
    persister.save(resource: change_set.resource)
  end

  private

  def default_metadata_adapter
    Valkyrie.config.metadata_adapter
  end

  def default_storage_adapter
    Valkyrie.config.storage_adapter
  end
end
