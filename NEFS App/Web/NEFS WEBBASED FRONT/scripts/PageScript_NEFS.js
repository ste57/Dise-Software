
function SomeDeleteRowFunction(btndel) {
    if (typeof(btndel) == "object") {
        if (confirm('Are you sure you want to delete this row?')) {
         $(btndel).closest("tr").remove();
        } else {
        // Do nothing!
        }
    } else {
        return false;
    }
}

//Dummy data
var data = {};
data.d = [{Category: 'Events', Created: 'Wednesday December 2014, 02:27', Last_edited: 'Wednesday December 2014, 02:27'}, 
          {Category: 'News', Created: 'Tuesday January 2014, 15:27', Last_edited: 'Tuesday December 2014, 02:27'},
          {Category: 'Info', Created: 'Monday June 2014, 05:24', Last_edited: 'Monday December 2014, 02:27'},
          {Category: 'Info', Created: 'Tuesday May 2014, 09:37', Last_edited: 'Wednesday December 2014, 02:27'},
          {Category: 'Sports', Created: 'Friday June 2014, 03:17', Last_edited: 'Friday December 2014, 02:27'},
          {Category: 'Events', Created: 'Tuesday March 2014, 08:43', Last_edited: 'Saturday December 2014, 02:27'},
          {Category: 'News', Created: 'Tuesday August 2014, 02:00', Last_edited: 'Wednesday December 2014, 02:27'},
          {Category: 'Sports', Created: 'Friday December 2014, 08:27', Last_edited: 'Thursday December 2014, 02:27'},
          {Category: 'News', Created: 'Friday July 2014, 19:25', Last_edited: 'Wednesday December 2014, 02:27'},
          {Category: 'Info', Created: 'Sunday July 2014, 12:56', Last_edited: 'Monday December 2014, 02:27'}];

/*
   var table = $("#table tbody");
    $.each(data, function(idx, elem){
        table.append("<tr><td>"+elem.Category+"</td><td>"+elem.Created+"</td>   <td>"+elem.Last_edited+"</td></tr>");
    });
*/

$(document).ready(function () {
    $('div.hidden').fadeIn(1000).removeClass('hidden');
});







