//link href= cdn.datatables.net/plug-ins/1.12.1/dataRender/datetime.js

window.addEventListener('DOMContentLoaded', event => {  
    const datatablesSimplePaymentList = document.getElementById('datatablesSimplePaymentList');

    if (datatablesSimplePaymentList) {
          $.ajax({
      url:"/payment/rest/listPayment",
      type:"POST",
      headers : {
                "Accept" : "application/json",
                "Content-Type" : "application/json",                                    
            },
        success: function(result) {            
            if(result) {
   
            console.log("js : rest/listPayment");
            var payments = result.list;
            var paymentData = [];
            var role = sessionStorage.getItem('role');
 
            
            payments.map((payment, i) => {
               console.log(payment);
               
               var temp = [];
               
               
               temp.push(i+1);
               temp.push(payment.payLessonName.lessonName);
               temp.push(payment.studentName);
               temp.push(payment.amount);
               temp.push(payment.payDueDate);
               temp.push(payment.payDay);
               temp.push(payment.checkPay);
               temp.push(payment.payCode);

               
               console.log(temp);
               
               paymentData.push(temp);
            })
            console.log(paymentData);
            
            var data = {
            
               "headings" : [
                  "NO",
                  "수업명",
                  "학생 이름",
                  "수납료",
                  "수납예정일",
                  "수납완료일",
                  "수납여부",
                  "결제하기",

               ],               
               "data" : paymentData,

            }

                 var realPayment = function(data, type, row){
              
                    var payCode = row.lastElementChild.textContent
   
                    return `<a href="/payment/getPayment/`+payCode+`">
                    <button class="btn btn-raised-warning type="button"> 상세보기 </button>
                    </a>`;
                 
                 }
                 
                 
                                       
            if(sessionStorage.getItem("role") == 'teacher') {
             var columns = [{
               select: 7,
               render: realPayment,
               hidden: true,
            }];
            
                     new simpleDatatables.DataTable(datatablesSimplePaymentList, {
         data,
         columns: columns,
         columnDefs: [
               {
                   targets: [0],
                   orderData: [0, 1],
               },
               {
                   targets: [1],
                   orderData: [0, 1],
               },
               {
                   targets: [2],
                   orderData: [0, 1],
               },
               {
                   targets: [3],
                   orderData: [0, 1],
               },
               {
                   targets: [4],
                   orderData: [0, 1],
               },
               {
                   targets: [5],
                   orderData: [0, 1],

               },
               {
                   targets: [6],
                   orderData: [0, 1],
               },
            ],   
      });
            
            
            
            
            
            
         }else {
         
          new simpleDatatables.DataTable(datatablesSimplePaymentList, {
         data,
         columns:[
            {
               select: 7,
               render: realPayment,
               
           }
                  
         
         ],
         columnDefs: [
               {
                   targets: [0],
                   orderData: [0, 1],
               },
               {
                   targets: [1],
                   orderData: [0, 1],
               },
               {
                   targets: [2],
                   orderData: [0, 1],
               },
               {
                   targets: [3],
                   orderData: [0, 1],
               },
               {
                   targets: [4],
                   orderData: [0, 1],
               },
               {
                   targets: [5],
                   orderData: [0, 1],

               },
               {
                   targets: [6],
                   orderData: [0, 1],
               },
            ],   
      });
         
         
         
         }
            
            
            
        
         }
      }
   })
   }
});




            