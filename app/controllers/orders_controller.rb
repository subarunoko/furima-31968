class OrdersController < ApplicationController
  before_action :set_order, only: [:index, :create]
  before_action :authenticate_user!
  before_action :contributor_confirmation, only: [:index, :create]
  
  def index
    @order_delivery_info = OrderDeliveryInfo.new
  end

  def new
  end

  def create 
    @order_delivery_info = OrderDeliveryInfo.new(order_params)
    if @order_delivery_info.valid?
      pay_item
      @order_delivery_info.save
      
      redirect_to root_path
    else
      render action: :index
    end
  end


  private

  def set_order
    if Order.exists?(item_id: params[:item_id])    #OrderテーブルにItemIDが登録されているどうか判定 ※覚書きのためコメント削除しません
      redirect_to root_path                  #IDがある場合 トップページへ戻る ※覚書きのためコメント削除しません
    else
      @order = Item.find(params[:item_id])   #IDがない場合 購入ページへ遷移する  商品情報のテーブルからデータを抽出 ※覚書きのためコメント削除しません
    end
  end

  def contributor_confirmation
    redirect_to root_path if current_user == @order.user
  end

  def order_params
    params.require(:order_delivery_info).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])  ##params[item_id]の取り出し方めっちゃ苦労した ※覚書きのためコメント削除しません
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] #テスト用の秘密鍵
    Payjp::Charge.create(
      amount: @order[:price],    #支払い金額
      card: order_params[:token], #カードトークン
      currency: "jpy"
    )
  end

end
