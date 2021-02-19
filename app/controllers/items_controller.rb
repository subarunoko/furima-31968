class ItemsController < ApplicationController
  def index
    @item = Item.new
  end

  def new
    @item = Item.new
  end

  def create
    # binding.pry
    @item = Item.new(item_params)
    if @item.save        # saveはアクティブレコードメソッド
      redirect_to root_path   # "保存成功"
    else
      render :new             #"保存失敗"
    end
  end
  
  private
  
  def item_params    #取得したいキーをpermitで調整 >>>>> 指定したキーのみ取得
    params.require(:item).permit(:title, :description, :price, :category_id, :state_id, :delivery_fee_id, :delivery_area_id, :delivery_days_id, :image).merge(user_id: current_user.id)  
  end

end
