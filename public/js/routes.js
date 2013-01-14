;(function($) {
  var app = $.sammy(function() {

    this.get('#/', function() {
      $('#notification').html(data.message);
    });

    this.get('#/osoby', function() {
      $('#notification').html("Sortowanie według osób");
      var obj = jQuery.parseJSON('{"id":[1,2],"name":["Klub A","Klub B"],"discription":["Nie ma nikogo","Nie ma nikogo"],"latlng":["50.095896,18.542544","51.095896,18.542544"],"max":["10","10"]}');
      $('#pubs').html("");
      for (var i=0;i<obj.id.length;i++)
      { 
        $('#pubs').html($('#pubs').html() + "<div class=\'pubs seven columns row\'><img src=\'\/images\/"+obj.id[i]+".jpg \'\/><h1>"+obj.name[i]+"<\/h1><h2>"+obj.discription[i]+"<\/h2><h3>"+obj.latlng[i]+"<\/h3><\/div>");     
      }
    });

    this.get('#/odleglosc', function() {
      $('#notification').html("Sortowanie według odleglosci");
    });

    this.get('#/alfabetycznie', function() {
      $('#notification').html("Sortowanie według alfabetu");
    });

  });

  $(function() {
    app.run()
  });
})(jQuery);