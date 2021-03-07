class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index ,:show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save        # saveはアクティブレコードメソッド
      redirect_to root_path   # "保存成功" トップページへ戻る
    else
      render :new             #"保存失敗"
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :destroy
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end


  private
  
  def set_item
    @item = Item.find(params[:id])
  end

  def contributor_confirmation
    # redirect_to root_path unless current_user == @item.user
    # binding.pry
    if @item.order.present?
      redirect_to root_path and return
    end
    # binding.pry
    if current_user != @item.user
      redirect_to root_path and return
    end
  end

  def item_params    #取得したいキーをpermitで調整 >>>>> 指定したキーのみ取得
    params.require(:item).permit(:title, :description, :price, :category_id, :state_id, :delivery_fee_id, :prefecture_id, :delivery_days_id, :image).merge(user_id: current_user.id)  
  end

end
