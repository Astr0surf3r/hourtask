$(document).on('turbolinks:load', function(){
  var select_number = $('select').length;
  console.log(select_number);
  
  for (var i = 1; i < select_number+1; i++) {
  
    console.log(i);
    $('#dynamic_company_' + i).on('change', function() {
      var url = $(this).val()
      console.log(url)
      if(url){
        window.location = url;
      }
      return false
    });
    
  }; //end for cycle

});