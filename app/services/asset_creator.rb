class AssetCreator
    def initialize(asset_params)
      @asset_params = asset_params
    end
  
    def create_asset
      Asset.create(@asset_params)
    end
end
  