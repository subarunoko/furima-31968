class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create, :create_done, :destroy_done, :search]
  # before_action :set_item, except: [:index, :new, :create, :create_done, :update_done, :destroy_done, :search]
  before_action :authenticate_user!, except: [:index ,:show, :search]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  # before_action :contributor_confirmation, only: [:edit, :update, :destroy, :create_done, :update_done, :destroy_coution, :destroy_done]
  before_action :order_exist, only: [:edit, :update]
  
  
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save        # saveはアクティブレコードメソッド
      redirect_to action: :create_done   # "保存成功" 完了ページへ戻る
    else
      render :new             #"保存失敗"
    end
  end

  def create_done
    @item = Item.order(updated_at: :desc).limit(1)       #最新のレコード1件取得
    @item = @item[0]
  end

  def destroy
    if @item.destroy
      redirect_to action: :destroy_done # "削除成功" 完了ページへ戻る
    else
      render :destroy
    end
  end

  def destroy_caution
  end

  def destroy_done
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      # redirect_to item_path(@item)
      redirect_to action: :update_done   # "保存成功" 完了ページへ戻る
    else
      render :edit
    end
  end

  def update_done
  end

  def search
    @items = Item.search(params[:keyword])
  end


  private
  
  def set_item
    @item = Item.find(params[:id])
  end

  # def contributor_confirmation
  #   # redirect_to root_path unless current_user == @item.user
  #   # binding.pry
  #   if @item.order.present?
  #     redirect_to root_path and return
  #   end
  #   if current_user != @item.user
  #     redirect_to root_path and return
  #   end
  # end

  def contributor_confirmation
    # redirect_to root_path unless current_user == @item.user
    if current_user != @item.user
      redirect_to root_path and return
    end
  end
  
  def order_exist
    if @item.order.present?
      redirect_to root_path and return
    end  
  end

  def item_params    #取得したいキーをpermitで調整 >>>>> 指定したキーのみ取得
    params.require(:item).permit(:title, :description, :price, :category_id, :state_id, :delivery_fee_id, :prefecture_id, :delivery_days_id, :image).merge(user_id: current_user.id)  
  end

end
