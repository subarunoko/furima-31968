class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index ,:show]
  
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save        # saveはアクティブレコードメソッド
      redirect_to root_path   # "保存成功"
    else
      render :new             #"保存失敗"
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end


  private
  
  def item_params    #取得したいキーをpermitで調整 >>>>> 指定したキーのみ取得
    params.require(:item).permit(:title, :description, :price, :category_id, :state_id, :delivery_fee_id, :prefecture_id, :delivery_days_id, :image).merge(user_id: current_user.id)  
  end

end
