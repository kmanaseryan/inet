var products = [];
$(document).ready(function(){


    $("#basket").click(function(){
        var value = "";
        var i;
        for(i = 0; i < products.length - 1; i++){
            value += products[i] + ",";
        }
        value += products[i];
        $('#basketForm').append('<input type="hidden" name="products" value="'+ value +'" />');
        $("#basketForm").submit();
    });

});

function add(product){
    $("#pr-" + product).fadeOut();
    products.push(product);
    var i = parseInt($("#basket .badge").text()) + 1;
    $("#basket .badge").empty().append(i);
    sessionStorage.setItem('products', JSON.stringify(products));
}