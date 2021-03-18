// require("jquery.jpostal")

$(function() {
  console.log("郵便番号自動入力ためのJavascript");
  $("#postal-code").css("color","red")
  $("#prefecture").css("color","red")
  $("#city").css("color","red")
  $("#addresses").css("color","red")
  $(document).on('turbolinks:load', () => {
    $('#postal-code').jpostal({
      postcode : [
        '#postal_code'
      ],
      address: {
        "#prefecture"     : "%3", // # 都道府県が入力される
        "#city"           : "%4%5", // # 市区町村と町域が入力される
        "#addresses"      : "%6%7" // # 大口事務所の番地と名称が入力される
      }
    });
  });
});



// $(document).on('turbolinks:load', function() {
//   $('#postal-code').jpostal({
//     postcode : [
//       '#postal-code'
//     ],
//     address: {
//       "#prefecture"     : "%3", // # 都道府県が入力される
//       "#city"           : "%4%5", // # 市区町村と町域が入力される
//       "#addresses"        : "%6%7" // # 大口事務所の番地と名称が入力される
//     }
//   });
// });


// const address_auto = () => {
//   console.log("郵便番号自動入力ためのJavascript");
//   $(document).on('turbolinks:load', function() { 
//     $('#postal-code').jpostal({
//       postcode : [
//         '#postal-code'
//       ],
//       address: {
//         "#prefecture"     : "%3", // # 都道府県が入力される
//         "#city"           : "%4%5", // # 市区町村と町域が入力される
//         "#addresses"      : "%6%7" // # 大口事務所の番地と名称が入力される
//       }
//     });
//   });
// };

// window.addEventListener("load", address_auto);


// # 入力項目フォーマット
// # %3 都道府県
// # %4 市区町村
// # %5 町域
// # %6 大口事業所の番地 ex)100-6080
// # %7 大口事業所の名称




// $(function(){
//   $("#prefecture").css("color","red")
// })


