// if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
//   document.addEventListener("DOMContentLoaded", function(){
//     // console.log(123);
//     const imageList = document.getElementById("image-list");
//     // document.getElementById('item_image').addEventListener('change', function(e){
//     //   console.log(e);
//     document.getElementById('item-image').addEventListener('change', function(e){
//         // console.log(e);
//         const ImageContent = document.querySelector('img');
//         if (imageContent){
//           imageContent.remove();
//         }
//         const file = e.target.files[0];
//         const blob = window.URL.createObjectURL(file);

//         //画像を表示するためのdiv要素を生成
//         const imageElement = document.createElement('div');

//         //表示する画像を生成
//         const blobImage = document.createElement('img');
//         blobImage.setAttribute('src', blob);

//         //生成したHTML要素をブラウザに表示
//         imageElement.appendChild(blobImage);
//         imageList.appendChild(imageElement);

//     });
//   });
// }



//プレビュー機能
// if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
//   document.addEventListener('DOMContentLoaded', function(){
//     const ImageList = document.getElementById('image-list');

//     const createImageHTML = (blob) => {
//        // 画像を表示するためのdiv要素を生成
//       const imageElement = document.createElement('div');

//       // 表示する画像を生成
//       const blobImage = document.createElement('img');
//       // Blob内で大きさを指定
//       blobImage.width = 200;
//       blobImage.height = 200;
//       // blobImage.position = "absolute";
//       // blobImage.left = 300 + "px";
//       // blobImage.top =  300 + "px";


//       blobImage.setAttribute('src', blob);

//       // 生成したHTMLの要素をブラウザに表示させる
//       imageElement.appendChild(blobImage);
//       ImageList.appendChild(imageElement);
//     };

//     document.getElementById('item-image').addEventListener('change', function(e){
//       // 画像が表示されている場合のみ、すでに存在している画像を削除する
//       // const imageContent = document.querySelector('img');
//       const imageContent = document.querySelector('img');
//       if (imageContent){
//         imageContent.remove();
//       }

//       const file = e.target.files[0];
//       const blob = window.URL.createObjectURL(file);

//       createImageHTML(blob);
//     });
//   });
// }



//プレビュー機能　複数枚投稿(自作コード)
// if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
//   document.addEventListener("DOMContentLoaded", function(){
//     const imageList = document.getElementById("image-list");

//     //選択した画像を表示する関数
//     const createImageHTML = (blob) => {
//       //画像を表示するためのdiv要素を生成
//       const imageElement = document.createElement('div');
//       imageElement.setAttribute('class', "image-element")
//       let imageElementNum = document.querySelectorAll('.image-element').length

//       //表示する画像を生成
//       const blobImage = document.createElement('img');
//       blobImage.setAttribute('src', blob);

//       //ファイル選択ボタンを生成
//       const inputHTML = document.createElement('input')
//       inputHTML.setAttribute('id', `item_image_${imageElementNum}`)
//       inputHTML.setAttribute('name', `item[images][]`)
//       inputHTML.setAttribute('type', 'file')

//       //生成したHTML要素をブラウザに表示
//       imageElement.appendChild(blobImage);
//       imageElement.appendChild(inputHTML);
//       imageList.appendChild(imageElement);

//       inputHTML.addEventListener('change', (e) => {
//         file = e.target.files[0];
//         blob = window.URL.createObjectURL(file);

//         createImageHTML(blob)

//       })
//     };

//     document.getElementById('item-image').addEventListener('change', function(e){
//       //画像が表示されている場合のみ既に存在している画像を削除する
//       // const imageContent = document.querySelector('item-image');
//       // if (imageContent){
//       //   imageContent.remove();
//       // } 

//       const file = e.target.files[0];
//       const blob = window.URL.createObjectURL(file);

//       createImageHTML(blob);

//     });
//   });
// }



//プレビュー機能　複数枚投稿(カリキュラム見本)
if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function() {
    const ImageList = document.getElementById('image-list')

    // 選択した画像を表示する関数
    const createImageHTML = (blob) => {
      // 画像を表示するためのdiv要素を生成
      const imageElement = document.createElement('div')
      imageElement.setAttribute('class', "image-element")
      let imageElementNum = document.querySelectorAll('.image-element').length

      // 表示する画像を生成
      const blobImage = document.createElement('img')
      // // Blob内で大きさを指定
      blobImage.width = 200;
      blobImage.height = 200;
      blobImage.setAttribute('src', blob)


      // ファイル選択ボタンを生成
      const inputHTML = document.createElement('input')
      inputHTML.setAttribute('id', `item-image_${imageElementNum}`)
      inputHTML.setAttribute('name', 'item[images][]')
      inputHTML.setAttribute('type', 'file')

      // 生成したHTMLの要素をブラウザに表示させる
      imageElement.appendChild(blobImage)
      imageElement.appendChild(inputHTML)
      ImageList.appendChild(imageElement)

      inputHTML.addEventListener('change', (e) => {
        file = e.target.files[0];
        blob = window.URL.createObjectURL(file);

        createImageHTML(blob)
      })
    }

    document.getElementById('item-image').addEventListener('change', (e) => {
      let file = e.target.files[0];
      let blob = window.URL.createObjectURL(file);

      createImageHTML(blob)

    });
  });
}