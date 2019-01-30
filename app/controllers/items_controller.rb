class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :update, :destroy]
  before_action :find_item_change_set, only: [:edit]

  delegate :persister, :query_service, to: :metadata_adapter

  # GET /items
  def index
    @items = query_service.find_all_of_model(model: Item)
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    @item = ItemChangeSet.new(Item.new)
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  def create
    @item = change_set_for(resource: Item.new(item_params))

    if change_set_persister.save(change_set: @item)
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /items/1
  def update
    @item = change_set_for(resource: @item)

    if change_set_persister.save(change_set: @item)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /items/1
  def destroy
    persister.delete(resource: @item)
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  private

  def change_set_for(resource:)
    change_set = ItemChangeSet.new(resource)
    change_set.validate(item_params)
    change_set.sync
    change_set
  end

  # Use callbacks to share common setup or constraints between actions.
  def find_item
    @item = query_service.find_by(id: params[:id])
  end

  def find_item_change_set
    @item = ItemChangeSet.new(find_item)
  end

  # Only allow a trusted parameter "white list" through.
  def item_params
    params.require(:item).permit(:title)
  end

  def metadata_adapter
    Valkyrie.config.metadata_adapter
  end

  def change_set_persister
    ChangeSetPersister.new(metadata_adapter: metadata_adapter)
  end
end
