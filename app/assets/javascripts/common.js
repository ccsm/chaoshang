    /*日期格式*/
    function ArrayWorkDate(date){
      var year = date.getFullYear()
      var month = date.getMonth()+1
      var day = date.getDate()
      return [year,month,day]
    }
    function formatWorkDateWithLine(date){
      arrDate = ArrayWorkDate(date)
      y = arrDate[0];m = arrDate[1];d=arrDate[2]
      var workDate = y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
      return workDate
    } 
    function formatWorkDate(date){
      arrDate = ArrayWorkDate(date)
      y = arrDate[0];m = arrDate[1];d=arrDate[2]
      var workDate = y + (m < 10 ? '0' + m : m) + (d < 10 ? '0' + d : d);
      return workDate
    } 
     /*日期比较*/
     function compareDate(strDate1,strDate2){
        var date1 = new Date(strDate1.replace(/\-/g, "\/"));
        var date2 = new Date(strDate2.replace(/\-/g, "\/"));
         return date1-date2;
     }


