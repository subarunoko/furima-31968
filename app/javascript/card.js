const pay = () => {
  console.log("カード情報トークン化のためのJavascript");
  Payjp.setPublicKey( process.env.PAYJP_PUBLIC_KEY); //Pay.JPテスト公開鍵 ※覚書きのため削除なし
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    // console.log("フォーム送信時にイベント発火") ※覚書きのため削除なし
    
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
    
    const card = {
      number: formData.get("order_delivery_info[number]"),
      cvc: formData.get("order_delivery_info[cvc]"),
      exp_month: formData.get("order_delivery_info[exp_month]"),
      exp_year: `20${formData.get("order_delivery_info[exp_year]")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        // console.log(token)   //トークン情報確認 ※覚書きのため削除なし
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name="token" type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      document.getElementById("charge-form").submit();

    });
  });
};


 window.addEventListener("load", pay);
